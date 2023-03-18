#!/bin/bash

set -Euo pipefail

mdadm --create /dev/md2 --level=1 --raid-disks=2 /dev/nvme0n1p2
mdadm --create /dev/md2 --level=1 --raid-disks=2 /dev/nvme0n2p2

mdadm --create /dev/md2 --level=1 --raid-disks=2 /dev/nvme0n2p3
mdadm --create /dev/md2 --level=1 --raid-disks=2 /dev/nvme0n2p3
