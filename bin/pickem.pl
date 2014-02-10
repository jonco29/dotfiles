#!/usr/bin/perl

die "specify file name with pickem copied from web page\n" if ($#ARGV < 0);
$file = $ARGV[0];
die "cannot open $file for reading!\n" if (!-e $file);

open FILE, $file or die "cannot open $file for reading\n";

@file = (<FILE>);
close FILE;
my @picks;
my $j = 0;

for ($i = 0; $i <= $#file; $i++) {
    next if ($file[$i] !~ /%/);
    $file[$i] =~ s,\s*$, ,;
    $pick .= $file[$i];
    if ($i % 2 == 1) {
        $pick =~ s,\s*$, ,;
        push @picks, $pick;
        $pick = "";
    }
}

foreach $tmp (@picks) {
    $tmp =~ s,\@ ,\@,;
    $hi = $tmp;
    $low = $tmp;
    $hi =~ s,%\s.*$,%,;
    $low =~ s,^.*%\s(.*\d%),$1,;

    $hi =~ s,(^[^\d]+)\s*(\d+%),$2--$1,;
    $hi =~ s,\s*$,,;
    $low =~ s,(^[^\d]+)\s*(\d+%),$2--$1,;
    $low =~ s,\s*$,,;

    $hi_num = $hi;
    $lo_num = $low;

    $hi_num =~ s,(^\d+).$,$1,;
    $lo_num =~ s,(^\d+).$,$1,;

    if ($hi_num > $lo_num) {
        $tmp = $hi . " " . $low;
    }
    else {
        $tmp = $low . " " . $hi;
    }
    # $tmp =~ s,\t,=========,g;
    ## ($hi,$low) = split / +/,$tmp;
    ## print "hi: $hi\n";
    ## print "low: $low\n";
    #print "$tmp\n";
}

@sorted = sort { $b <=> $a } @picks;

$i = $#sorted + 1;
foreach $tmp (@sorted) {
    print "$i\t$tmp\n";
    $i--;
}



