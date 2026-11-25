# Installing nixos-pc on btrfs

`nixos-pc` expects one btrfs partition (`nvme0n1p6`) with these subvolumes:

| Subvolume | Mount point | Options |
|---|---|---|
| `@` | `/` | `noatime,compress=zstd` |
| `@home` | `/home` | `noatime,compress=zstd` |
| `@nix` | `/nix` | `noatime,compress=zstd` |
| `@log` | `/var/log` | `noatime,compress=zstd` |
| `@swap` | `/swap` | `noatime` (swapfiles must not be compressed) |

`/boot` stays on `nvme0n1p5`. Leave the Windows partitions (`p1`–`p4`) and `p7`/`p8` alone.

Two values only exist after formatting, so the config leaves them `null` and the build fails until they
are set:

- `btrfsUuid` in `modules/hosts/nixos-pc/hardware.nix`
- `resumeOffset` in `modules/hosts/nixos-pc/features/suspend-hibernate.nix`

## Before

- Back up `/home` (at least `~/Projects`, `~/.ssh`, `~/.gnupg`); formatting `p6` erases it.
- Push this repository.

## Install

From the NixOS installer, as root:

```sh
mkfs.btrfs -f -L nixos /dev/nvme0n1p6
mount /dev/nvme0n1p6 /mnt
for s in @ @home @nix @log @swap; do btrfs subvolume create /mnt/$s; done
umount /mnt

o=noatime,compress=zstd
mount -o subvol=@,$o /dev/nvme0n1p6 /mnt
mkdir -p /mnt/{home,nix,var/log,swap,boot}
mount -o subvol=@home,$o /dev/nvme0n1p6 /mnt/home
mount -o subvol=@nix,$o /dev/nvme0n1p6 /mnt/nix
mount -o subvol=@log,$o /dev/nvme0n1p6 /mnt/var/log
mount -o subvol=@swap,noatime /dev/nvme0n1p6 /mnt/swap
mount /dev/nvme0n1p5 /mnt/boot

# nocow and uncompressed, as btrfs requires for swap
btrfs filesystem mkswapfile --size 10g /mnt/swap/swapfile

blkid -s UUID -o value /dev/nvme0n1p6                       # -> btrfsUuid
btrfs inspect-internal map-swapfile -r /mnt/swap/swapfile   # -> resumeOffset
```

Clone the repository to `/mnt/home/hiepnh/.nixcfg`, set the two values, then install:

```sh
nixos-install --flake /mnt/home/hiepnh/.nixcfg#nixos-pc \
  --option extra-substituters "https://justanoobcoder.cachix.org https://umbriel.cachix.org https://cache.lantian.pub/lantian https://noctalia.cachix.org" \
  --option extra-trusted-public-keys "justanoobcoder.cachix.org-1:D2/vJZSn8o8Fpsxzbjc9tHo2/D1ejBUqc4r71UvDVyk= umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw= lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ= noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
```

The binary caches in `nix.settings` only take effect once the new system is running, so pass them to
`nixos-install`; without them the CachyOS kernel and the `justanoobcoder/*` packages build from source.

The private inputs (`unda`, `fcitx5-jot`, `keywave`, `jon`) are fetched over SSH (`git+ssh://`), and
`nixos-install` runs as root, which has no key for them. Copy a key that can read those repositories to
`/root/.ssh` first.

After the first boot, restore the backup into `/home/hiepnh` and fix ownership.

## Check

- `findmnt -t btrfs` lists the five subvolumes.
- `swapon --show` lists `/swap/swapfile`.
- `nix shell nixpkgs#compsize -c sudo compsize /nix` shows how well the store compresses.
- `systemctl list-timers 'btrfs-scrub*'` shows the monthly scrub.
