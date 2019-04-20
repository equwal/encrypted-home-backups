#!/usr/bin/perl
use strict;
use warnings;
my $uuid = $ARGV[0];
my $keyfile = $ARGV[1];
my $user = $ARGV[2];
my $mountfolder = $ARGV[3];
# Put auto-dev-detect code here
my $last_half = '';
my $blkid = `blkid`;
for(split "\n", $blkid) {
    print;
    print "\n";
    if(m#$uuid#) {
        m#/dev/(.*):#;
        $last_half = $1;
        last;
    }
}
if($last_half eq '') {
    die "Failed to associate a dev device with that UUID.";
} else {
    print "Last half: $last_half\n";
}
my $mount = "$mountfolder/$last_half";
`cryptsetup --key-file $keyfile luksOpen /dev/$last_half $last_half`;
`mkdir -p $mount`;
`mount /dev/mapper/$last_half $mount`;
# Do a home-only backup
my $date = `date`;
my $fname = "$mount/backup-$date";
`mkdir '$fname'`;
`cp -a /home/$user '$fname'`;
