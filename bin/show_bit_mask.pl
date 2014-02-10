#!/usr/bin/perl

if ($#ARGV < 0)
{
    die "must supply input file\n";
}
foreach $tmp (@ARGV)
{
    my $val = $tmp;
    $val =~ s,0x,,;
    $val = hex $val;

    $bin = pack "N", $val;
    $bin = unpack "B*", $bin;
    my $bin_len = length $bin;

    $bin = reverse $bin;
    $bin =~ s|([01]{1,4})|$1  |g;
    $bin =~ s,\s*$,,;

    my $mask = "";
    my $use_space = 1;
    for ($i = 0; $i < $bin_len; $i++)
    {
        if ($i%4 == 3)
        {
            $mask = $i . $mask;
            if ($i < 10)
            {
                $mask = " ".$mask;
            }
        }
        $mask = " ".$mask;
    }


    $bin = reverse $bin;
    $tmp_str = sprintf ("0x%04X -- %s\n", $val, $bin);
    @junk = split / -- /, $tmp_str;
    $tmp_str = " " x (length($junk[0]) + 2) . $mask;
    print "$tmp_str\n";
    printf ("0x%04X -- %s\n", $val, $bin);
}



