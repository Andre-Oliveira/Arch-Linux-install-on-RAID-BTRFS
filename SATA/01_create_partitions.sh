#!/bin/bash

set -Euo pipefail

sgdisk -z /dev/sda
sgdisk -z /dev/sdb

sgdisk -n 1:0:+512M -t 1:ef00 -c 1:'EFI' /dev/sda
sgdisk -n 2:0:+8G -t 2:fd00 -c 2:'RAID [swap]' /dev/sda
sgdisk -n 3:0:0 -t 3:fd00 -c 3:'RAID [system]' /dev/sda
sgdisk /dev/sda -R /dev/sdb -G

fdisk -l /dev/sda
fdisk -l /dev/sdb
