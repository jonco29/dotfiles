#!/usr/bin/perl



open SREC, "$ARGV[0]" or die "cannot open $ARGV[0]\n";
my @srec = (<SREC>);
close SREC;

my $tmp;

foreach $tmp (@srec)
{
    $tmp = calc_srec_crc($tmp);
}

open OUT , ">$ARGV[0].srec" or die ;

foreach $tmp (@srec)
{
    print OUT "$tmp\n";
}

close OUT;
exit 1;


## update the length in the srecord
$srec[1] = update_length ($srec[1], $length);
$srec[1] = calc_srec_crc($srec[1]);

## put the CRLF on here to match
$srec[1] .= "\r\n";

$length = hex $length;
$lines = int($length/16);
## adjust for the header
$lines += 2;

$byte = int($length % 16) + 1;
## adjust for SREC decorations
$byte += 5;

## now update the signature on the srec
update_srec_sig(\@srec, $lines, $byte);

foreach $tmp (@srec)
{
    print $tmp;
}



## foreach $tmp (@srec)
## {
##     $line =  calc_srec_crc($tmp);
##     print "$line\n";
## }

## Routine to update the srecord signature
## the srecord is passed by reference, thus it will
## get updated automatically.  the 'lines' parameter
## indicates the line number (as caluclated from the CSF file)
## the 'byte' parameter indicates the current byte at the
## start of the signature.
##
## this routine will open psk_sig.c, rip out the contents
## and update each srecord line, including updating the CRC
sub update_srec_sig
{
    my $srec = shift;
    my $lines = shift;
    my $byte = shift;
    my $tmp;
    my @sig;
    my $sig;
    my $cur_byte = $byte;
    my $cur_line = $lines;
    my $i;


    open PSK, "psk_sig.c" or die "cannot open psk_sig.c\n";
    @sig = (<PSK>);
    close PSK;
    @sig = grep /0x/i, @sig;

    foreach $tmp (@sig)
    {
        $tmp =~ s/,*\s*[^0-9a-fx]*$//i;
        $tmp =~ s,0x,,g;
        $tmp =~ s/,//g;
        $tmp =~ s,^\s+,,;
        $tmp =~ s, +,,g;
    }

    ## now put the signature into a long line
    $sig = join "", @sig;
    @sig = ();

    ## now split back into an array of individual elements
    ## read srec into an array
    split_srec_line($sig, \@sig);

    $cur_line = @$srec[$lines];
    my @cur_line;
    split_srec_line($cur_line, \@cur_line);
    my $line_length = $cur_line[1] + 1;
    foreach $tmp (@sig)
    {
        $cur_line[$cur_byte++] = $tmp;
        if ($cur_byte >= $line_length)
        {
            my $tmp2;
            my $new_line = "";

            $new_line = shift @cur_line;
            foreach $tmp2 (@cur_line)
            {
                $new_line .= sprintf("%2.2X", $tmp2);
            }

            #$cur_line = join "", @cur_line;
            $cur_line = calc_srec_crc($new_line);
            @$srec[$lines] = $cur_line . "\r\n";
            $lines++;

            $cur_line = @$srec[$lines];
            @cur_line = ();
            split_srec_line($cur_line, \@cur_line);
            $cur_byte = 6;
            $line_length = $cur_line[1] + 1;
        }
    }

}

sub split_srec_line
{
    my $srec_line = shift;
    my $srec_array = shift;
    my $tmp;

    ## read srec into an array
    while ($srec_line =~ /([a-f0-9s]{2,2})/ig)
    {
        $tmp = $1;
        if ($tmp !~ /s/i)
        {
            $tmp = hex $tmp;
        }
        push @$srec_array, $tmp;
    }
}


## routine to retrieve the hex value of the length
## from the .csf file
sub get_csf_length_as_hex
{
    my @csf;
    my @tmp;
    my @len;

    ## now, read in CSF for length
    open CSF, "prod.csf" or die "cannot open prod.csf\n";
    @csf = (<CSF>);
    close CSF;
    @len = grep /srec/i, @csf;

    $len[0] =~ s,^.*0x,,;
    $len[0] =~ s,[^0-9a-f]+$,,i;
    return $len[0];
}
    
## Routine to update the length on the srecord line
## base on the passed in srec line and the passed in 
## length
sub update_length
{
    my $srec_line = shift;
    my $csf_length = shift;
    my @srec;
    my @csf;
    my @tmp;
    my @length;
    my $i;


    ## first remove any CR-LF crap
    $srec_line =~ s,[^0-9A-F]+$,,i;

    ## read srec into an array
    split_srec_line($srec_line, \@srec);

    while ($csf_length =~ /([a-f0-9s]{2,2})/ig)
    {
        push @length, hex($1);
    }

    ## account for little endian
    @length = reverse @length;

    ## now update the length
    my $srec_index = 18;
    my $i = 0;
    for ($i = 0; $i <=$#length; $i++)
    {
        $srec[$srec_index++] = $length[$i];
    }

    ## now build it back to a string
    my $new_srec_line = shift @srec;
    foreach $tmp (@srec)
    {
        $new_srec_line .= sprintf("%2.2X", $tmp);
    }
    #print $new_srec_line,"\n";
    return $new_srec_line;
}

## Routine to calculate a CRC on an SREC line
## it will look for an existing CRC and delete it
## if necessary.  If a CRC does not exist on the line
## it will append it.
sub calc_srec_crc
{
    my $srec_line = shift;
    my $line_len = $srec_line;
    my @srec;
    my $tmp;

    ## first remove any CR-LF crap
    $srec_line =~ s,[^0-9A-F]+$,,i;

    ## read srec into an array
    split_srec_line($srec_line, \@srec);

    ## if length field matches length, there is a 
    ## crc included.  remove it
    if ($#srec == ($srec[1] + 1 ))
    {
        pop @srec;
    }

    my $sum = 0;
    my $i;
    for ($i = 1; $i <= $#srec; $i++)
    {
        $sum += $srec[$i];
    }

    $sum = ~$sum;
    my $cksum;
    $cksum = sprintf("%x", ($sum & 0xff));

    push @srec, hex($cksum);


    my $new_srec_line = shift @srec;
    foreach $tmp (@srec)
    {
        $new_srec_line .= sprintf("%2.2X", $tmp);
    }
    #print $new_srec_line,"\n";
    return $new_srec_line;
}

