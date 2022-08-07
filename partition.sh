parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 600MiB
parted /dev/nvme0n1 -- mkpart primary linux-swap 600MiB 20GiB
parted /dev/nvme0n1 -- mkpart primary 20GiB 150GiB
parted /dev/nvme0n1 -- mkpart primary 150GiB 100%
parted /dev/nvme0n1 -- set 1 boot on

mkfs.fat -F32 -n boot /dev/nvme0n1p1
mkswap -L swap /dev/nvme0n1p2
mkfs.ext4 -L nixos /dev/nvme0n1p3
mkfs.ext4 -L home /dev/nvme0n1p4

umount /dev/disk/by-label/boot
umount /dev/disk/by-label/home
umount /dev/disk/by-label/nixos
swapon /dev/disk/by-label/swap
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/{home,boot,boot/efi}
mount /dev/disk/by-label/boot /mnt/boot/efi
mount /dev/disk/by-label/home /mnt/home

