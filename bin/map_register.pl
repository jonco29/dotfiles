#!/usr/bin/perl
#
my @answer;
my $answer;
my $tmp;

foreach $tmp (@ARGV)
{
    #print "$tmp\n";
    push @answer, get_mask($tmp);
}
$anser = 0;
foreach $tmp (@answer)
{
    $answer |= $tmp;
}

#printf("0x%08x -- %b\n", $answer, $answer);
my $int = sprintf("%08x", $answer);
my $binary = sprintf("%b", $answer);
while ($int =~ /([\da-fA-F]{2,2})/g) { print "$1 ";}
print " -- ";
my $len = length $binary;
$len = 32 - $len;
$binary = 0 x $len . $binary;
while ($binary =~ /([01]{8,8})/g){print "$1 ";};
print "\n";


sub get_mask
{
    my $val = shift;
    my $str = 'b0';
    if ($val =~ /\d+/)
    {
        if ($val > 0)
        {
            $str = 'b1' . 0 x $val;
        }
        elsif ($val == 0)
        {
            $str = "b1";
        }
    }
    $val = oct $str;
    return $val;
}


