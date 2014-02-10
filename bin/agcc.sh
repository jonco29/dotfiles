#!/bin/bash

# Copyright 2012, Jiang Yio <inportb@gmail.com>
# Distributable under the terms of the GNU GPL, see COPYING for details
# Based on original Perl script by Andrew Ross <andy@plausible.org>

# The Android toolchain is ... rough.  Rather than try to manage the
# complexity directly, this script wraps the tools into an "agcc" that
# works a lot like a gcc command line does for a native platform or a
# properly integrated cross-compiler.  It accepts arbitrary arguments,
# but interprets the following specially:
#
# -E/-S/-c/-shared - Enable needed arguments (linker flags, include
#                    directories, runtime startup objects...) for the
#                    specified compilation mode when building under
#                    android.
#
# -O<any> - Turn on the optimizer flags used by the Dalvik build.  No
#           control is provided over low-level optimizer flags.
#
# -W<any> - Turn on the warning flags used by the Dalvik build.  No
#           control is provided over specific gcc warning flags.
#
# Environment Variables:
# + PATH:
#   points to the prebuilt arm-linux-androideabi-gcc from a built (!)
#   android source directory or NDK
# + AGCC_NDK: contains the path to the NDK
# + AGCC_API=8:
#   specifies the API level
# + AGCC_CXC=arm-linux-androideabi:
#   specifies the prefix of the prebuilt tools
# + AGCC_GCC=4.4.3:
#   selects the GCC version
# + AGCC_ECHO:
#   tells me to echo the resulting command before running it
#
# Notes:
# + All files are compiled with -fPIC to an ARMv5TE target.  No
#   support is provided for thumb.
# + No need to pass a "-Wl,-soname" argument when linking with
#   -shared, it uses the file name always (so don't pass a directory in
#   the output path for a shared library!)
# + Works with NDK distributions
#   + android-ndk-r6-linux-x86
#   + android-ndk-r7-linux-x86 (with __aeabi_unwind_cpp_pr0 errors)

if [ "$AGCC_ECHO" != "" ]; then
	echo " => $0 $@"
fi

if [ "$AGCC_NDK" == "" ]; then
    echo you need to set AGCC_NDK to the top of your NDK directory
    exit 1
	#AGCC_NDK=$HOME/android-ndk
else
    echo using AGCC_NDK: $AGCC_NDK
fi
if [ "$AGCC_API" == "" ]; then
	AGCC_API="9"
fi
if [ "$AGCC_CXC" == "" ]; then
	AGCC_CXC=arm-linux-androideabi
fi
if [ "$AGCC_GCC" == "" ]; then
	AGCC_GCC="4.4.3"
fi

PLATFORM=$AGCC_NDK/platforms/android-$AGCC_API/arch-arm
TOOLCHAIN=$AGCC_NDK/toolchains/$AGCC_CXC-$AGCC_GCC
PREBUILT=$TOOLCHAIN/prebuilt/linux-x86
LDSCRIPTS=$PREBUILT/$AGCC_CXC/lib/ldscripts

INC="-I$PLATFORM/usr/include"

CPP="-D__ARM_ARCH_5__ -D__ARM_ARCH_5T__ -D__ARM_ARCH_5E__ -D__ARM_ARCH_5TE__ -DANDROID -DSK_RELEASE -DNDEBUG -UDEBUG"

WFLAGS="-Wall -Wno-unused -Wno-multichar -Wstrict-aliasing=2"

CFLAGS="-march=armv5te -mtune=xscale -msoft-float -mthumb-interwork -fpic -fno-exceptions -ffunction-sections -funwind-tables -fmessage-length=0"

OFLAGS="-O2 -finline-functions -finline-limit=300 -fno-inline-functions-called-once -fgcse-after-reload -frerun-cse-after-loop -frename-registers -fomit-frame-pointer -fstrict-aliasing -funswitch-loops"

LDFLAGS="-Bdynamic -Wl,-T,$LDSCRIPTS/armelf_linux_eabi.x -Wl,-dynamic-linker,/system/bin/linker -Wl,--gc-sections -Wl,-z,nocopyreloc -Wl,--no-undefined -Wl,-rpath-link=$PLATFORM -L$PLATFORM/usr/lib -nostdlib $PLATFORM/usr/lib/crtend_android.o $PLATFORM/usr/lib/crtbegin_dynamic.o -lc $PREBUILT/lib/gcc/$AGCC_CXC/$AGCC_GCC/libgcc.a -lm -ldl"

SHFLAGS="-nostdlib -Wl,-T,$LDSCRIPTS/armelf_linux_eabi.xsc -Wl,--gc-sections -Wl,-shared,-Bsymbolic -Wl,-rpath-link=$PLATFORM -L$PLATFORM/usr/lib -Wl,--no-whole-archive -lc -lm -Wl,--no-undefined $PREBUILT/lib/gcc/$AGCC_CXC/$AGCC_GCC/libgcc.a -Wl,--whole-archive"	# .a, .o input files go *after* here

# Now implement a quick parser for a gcc-like command line

MODE=DEFAULT
OUT=
WARN=0
OPT=0
ARGS=
SRC=0

while true; do
	shopt -u nocasematch
	case "$1" in
		'-E'|'-c'|'-S'|'-shared')
			if [ "$MODE" != DEFAULT ] && [ "$MODE" != "$1" ]; then
				echo "cannot specify $MODE and $1" 1>&2
				exit 1
			else
				MODE=$1
			fi
			;;
		'-o')
			if [ $# -gt 1 ]; then
				if [ "$OUT" != "" ]; then
					echo "duplicate -o argument" 1>&2
					exit 1
				else
					shift
					OUT=$1
				fi
			else
				echo "-o requires an argument" 1>&2
				exit 1
			fi
			;;
		*)
			if [[ $1 =~ ^-W.* ]]; then
				WARN=1
			else
				if [[ $1 =~ ^-O.* ]]; then
					OPT=1
				else
					shopt -s nocasematch
					if [[ $1 =~ \.(c|cpp|cxx)$ ]]; then
						SRC=1
					fi
					shopt -u nocasematch
					ARGS="$ARGS $1"
				fi
			fi
			;;
	esac
	if [ $# -gt 1 ]; then
		shift
	else
		break
	fi
done

NEED_CPP=0
NEED_COMPILE=0
NEED_LINK=0
NEED_SHLINK=0
case "$MODE" in
	DEFAULT)
		NEED_CPP=1
		NEED_COMPILE=1
		NEED_LINK=1
		;;
	'-E')
		NEED_CPP=1
		;;
	'-c'|'-S')
		NEED_CPP=1
		NEED_COMPILE=1
		;;
	'-shared')
		NEED_SHLINK=1
		;;
esac

if [ $SRC -ne 0 ] && [ "$MODE" != '-E' ]; then
	NEED_CPP=1
	NEED_COMPILE=1
fi

# Assemble the command

CMD="${PREBUILT}/bin/${AGCC_CXC}-gcc"
if [ "$MODE" != DEFAULT ]; then
	CMD="$CMD $MODE"
fi
if [ "$OUT" != "" ]; then
	CMD="$CMD -o $OUT"
fi
if [ $NEED_CPP -ne 0 ]; then
	CMD="$CMD $INC $CPP"
fi
if [ $NEED_COMPILE -ne 0 ]; then
	CMD="$CMD $CFLAGS $CFLAGS"
	if [ $WARN -ne 0 ]; then
		CMD="$CMD $WFLAGS"
	fi
	if [ $OPT -ne 0 ]; then
		CMD="$CMD $OFLAGS"
	fi
fi
if [ $NEED_SHLINK -ne 0 ]; then
	CMD="$CMD $SHFLAGS"
fi
CMD="$CMD $ARGS"
if [ $NEED_LINK -ne 0 ]; then
	CMD="$CMD $LDFLAGS"
fi

if [ "$AGCC_ECHO" != "" ]; then
	echo " <= $CMD"
fi

echo jonco: $CMD
exec $CMD
