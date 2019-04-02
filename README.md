# Automatic encrypted /home backups

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

Mount folder cannot be in the `/home`.

Execute it as root with the device plugged in.

`# ./backup`
