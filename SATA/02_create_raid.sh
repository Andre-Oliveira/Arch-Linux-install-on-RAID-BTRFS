#!/bin/bash

set -Euo pipefail

mdadm --create /dev/md2 --level=1 --raid-disks=2 /dev/sda2 /dev/sdb2

mdadm --create /dev/md3 --level=1 --raid-disks=2 /dev/sda3 /dev/sdb3