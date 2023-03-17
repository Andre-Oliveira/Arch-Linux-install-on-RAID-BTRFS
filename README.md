# Installation of Arch Linux on RAID with the BTRFS filesystem

## Base system installation

### Mount USB drive containing instalation scripts in the 'arch_install' directory 
Assuming here that /dev/sda is USB stick containing arch linux installation and /dev/sdb contains our configuration scripts
```
mkdir /store
mount /dev/sdb1 /store
cd /store/arch_install
```
### Run all the scripts that handle disk management 
The script accepts "sata" and "nvme" as valid inputs

example:
```
sh 00_setup_scripts.sh sata
```

### Download system files
```
./06_pacstrap.sh
```

### Create fstab and mdadm config, remove resolv.conf
```
./07_pre_chroot.sh
```

### Chroot into the new filesystem
```
cd
umount /store
arch-chroot /mnt
mount /dev/sdb1 /mnt
cd /mnt/arch_install
```

### Setup timezone, language, ntworking, create ramdrive, update sudoers config
```
./10_post_chroot.sh
```

### Install grub
```
./11_install_grub.sh
```

### Setup root password
```
passwd
```

### Instal KDE Plasma
```
./12_install_gui.sh
```

### Setup snapper and make initial snapshot
```
./13_setup_snapper.sh
```

### Exit chroot environment and reboot
```
exit
reboot
```

## Optional steps

### Add user
```
useradd -mG wheel herman
passwd herman

snapper -c root create —description 'Initial install, users'

```

### Install nvidia drives (from local user in gnome)
```
pacman -S nvidia
echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf
mkdir -p /etc/pacman.d/hooks
```

```
vi /etc/pacman.d/hooks/nvidia.hook

[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

```
vi /etc/X11/xorg.conf.d/10-nvidia.conf

Section "OutputClass"
Identifier "nvidia"
MatchDriver "nvidia-drm"
Driver "nvidia"
Option "AllowEmptyInitialConfiguration"
Option "PrimaryGPU" "yes"
ModulePath "/usr/lib/nvidia/xorg"
ModulePath "/usr/lib/xorg/modules"
EndSection
```

```
vi /etc/mkinitcpio.conf
  # Update line 'MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'

mkinitcpio -p linux

snapper -c root create —description 'Initial install, users, gui, nvidia'
```

### Rollback to given snaphot

```
snapper list
snapper rollback <image number>
reboot
```
