# Automatic Daily Encrypted /home Backups

# Install
Encrypt and install filesystems on the backup disk.

``` shell
# lsblk
# parted /dev/sdb
> mktable
> mkpart
# cryptsetup luksFormat /dev/sdb1
# cryptsetup luksOpen /dev/sdb1 sdb1
# mkdir /mnt/sdb1
# mount /dev/mapper/sdb1 /mnt/sdb1
# mkfs.ext4 /mnt/sdb1
# umount /dev/mapper/sdb1
```

Modify the user-data bash file (`backup`) to fit your keyfile, UUID, username,
and mount folder.

Keyfile should just be a plaintext file with the password for the disk.

Get the uuid with `# blkid` on the partition.

Username is for the folder to backup under `/home`.

Mount folder cannot be in the `/home/username` and must exist: `# mkdir /mnt`.

Install it

`root # ./install`

Run it for the first backup and to verify install to /usr/bin.

`root # backup`

Or, if you have cron installed, it will install itself in cron.daily for fully
automated daily encrypted backup.
