#!/usr/bin/perl

use Audio::Wav;

die "usage $0 <input_file.wav>\n" unless ($#ARGV==0);
my $input_file = $ARGV[0];

die "cannot open file: $input_file for reading!\n" unless (-e $input_file);
print ("#" x 80);
print "\n";
print "working on $input_file\n";


my $wav = new Audio::Wav;
my $read = $wav -> read( $input_file );
#my $write = $wav -> write( 'output.wav', $read -> details() );
print "input is ", $read -> length_seconds(), " seconds long\n";

#exit 1;

#$write -> set_info( 'software' => 'Audio::Wav' );
my $data;
#read 512 bytes
#while ( defined( $data = $read -> read_raw( 512 ) ) ) {
my $stop = 0;
my $left = 0;
my $right = 0;
my $count = 0;
my $left_count = 0;
my $right_count = 0;

while ( (defined( $data = $read -> read_raw( 4 ) ) ) && !($left != 0 &&  $right != 0 )) {
    #$write -> write_raw( $data );
    $count ++;
    my @a = unpack "s*", $data;

    printf ("0x%04x 0x%04x\n", $a[0] & 0xffff, $a[1]& 0xffff);

    ## if (($a[0] >= 0x1000 || $a[0] <= -4096) && $left == 0 && $right != 0) {
    ##     #print "setting left\n";
    ##     $left = $a[0];
    ##     $left_count = $count;
    ## }
    ## if (($a[1] >= 0x1000 || $a[1] <= -4096) && $right == 0) {
    ##     print "setting right\n";
    ##     $right = $a[1];
    ##     $right_count = $count;
    ## }

    # if ($a[0] >= 10851 || $a[1] >= 10851)
    # {
    #      print "haaaa haaa\n";
    # }

    # if ($count >=10850)
    # {
    #     print "haaaa haaa\n";
    # }
}
print "this is left: $left\n";
print "this is right: $right\n";
print "this is left_count: $left_count\n";
print "this is right_count: $right_count\n";
print "this is r-l (delta) count: ", ($left_count - $right_count), "\n";

#print "hello\n";
