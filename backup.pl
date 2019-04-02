#!/usr/bin/perl
use strict;
use warnings;
my $uuid = $ARGV[0];
my $keyfile = $ARGV[1];
my $user = $ARGV[2];
my $mountfolder = $ARGV[3];
# Put auto-dev-detect code here
my $last_half;
my $blkid = `blkid`;
print "$blkid\n$uuid\n$keyfile";
if($blkid =~ /(.*)$uuid.*/) {
    print $1;
    my $tmp = $1;
    $tmp =~ m#/dev/(.*?):#;
    $last_half = $1;
} else {
    die "Could not get a device ID from that UUID."
}
my $mount = "$mountfolder/dev/$last_half";
my $mapper = "/dev/mapper/$last_half";
`cryptsetup --key-file $keyfile luksOpen /dev/$last_half $last_half`;
`mkdir -p $mount`;
`mount /dev/mapper/$last_half $mount`;
# Do a home-only backup
my $date = `date`;
my $fname = "$mount/backup-$date";
`mkdir '$fname'`;
`cp -a /home/$user '$fname'`;
