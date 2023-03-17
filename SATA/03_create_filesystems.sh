#!/bin/bash

set -Euo pipefail

mkfs.fat -F32 /dev/sda1
mkfs.fat -F32 /dev/sdb1
mkswap /dev/md2
mkfs.btrfs -f /dev/md3

