set -Euo pipefail

cd
umount /store
arch-chroot /mnt
mount /dev/sdb1 /mnt
cd /mnt/Arch-Linux-install-on-RAID-BTRFS