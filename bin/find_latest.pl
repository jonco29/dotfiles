#!/usr/bin/perl

use Cwd;
use Getopt::Std;


## get the name of the invoked script for use in help
## try to make it work for dos or unix.
## if you want the entire path, simply use $0...
#@name = split m[/|\\], $0;
#$name = $name[$#name];
$name = $0;
$name =~ s|^.*[\\/]||;


$opt_t = 0;     ## specify the tag
$opt_h = 0;     ## request help
$opt_b = 0;     ## specify the branch
$opt_f = 0;     ## show file names only
$opt_e = 0;     ## convert to clearcase elements
getopts( "htbfe" );


if ($#ARGV < 0 || $opt_h) {
    print << "__EOH_";
usage: $name [-feh] [-t <tags>] or [-b <branches>] 
    -f  show file names only (no branch information 
    -e  show as clearcase elements
    -h  help

where there can be multiple tag names or branch names listed

NOTE: the default behavior is to seach branches, thus '-b' is optional
__EOH_
}

$cwd = cwd();
## is this cygwin?
if ($ENV{'XTERM_SHELL'}) {
    $cwd =~ s|/\w{2,}/\w/|/|;
}

foreach $arg (@ARGV) {
    ## fucking DOS, doesn't like ' for some reason
    $cmd = &get_cmd($arg);
    open CMD, "$cmd|" ;

    while (<CMD>) {
        $output = $_;
        $output =~ s|\\|/|g;
        ## if files only, whack '@@' and on
        if ($opt_f) {
            $output =~ s/@@.*//;
        }
        ## else if we need to make clearcase elements
        ## whack the drive letter if it exists & replace the start w/ 'element'
        ## also replace the '@@' w/ ' '
        elsif ($opt_e){
            $output =~ s|^(\w:)?|element |;
            $output =~ s|@@| |;
        }
        ## get rid of any pesky cr/lf's 
        $output =~ s/(\w)\s*$/\1/;
        print $output,"\n";
    }
    
    close CMD;
}

sub get_cmd {
    my $arg = shift;
    my $cmd = "cleartool find $cwd -ver \"version(.../$arg/LATEST)\" -print";
    if ($opt_t) {
       $cmd = "cleartool find $cwd -ver \"lbtype($arg)\" -print";
    }
    return $cmd;
}

