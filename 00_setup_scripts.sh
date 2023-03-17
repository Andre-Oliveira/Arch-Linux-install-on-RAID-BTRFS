set -Euo pipefail

# mkdir /store
# mount /dev/sdb1 /store
# cd /store/Arch-Linux-install-on-RAID-BTRFS

ANSWER=$1

if [ $ANSWER = "sata" ]; then	
    sh SATA/01_create_partitions.sh
    sh SATA/02_create_raid.sh
    sh SATA/03_create_filesystems.sh
    sh SATA/04_configure_btrfs.sh
    sh SATA/05_mount_btrfs.sh
elif [ $ANSWER = "nvme" ]; then
    sh NVMe/01_create_partitions.sh
    sh NVMe/02_create_raid.sh
    sh NVMe/03_create_filesystems.sh
    sh NVMe/04_configure_btrfs.sh
    sh NVMe/05_mount_btrfs.sh
else
	echo "Script does not support your setup"
fi