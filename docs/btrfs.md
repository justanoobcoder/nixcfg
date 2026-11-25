# Installing nixos-pc on btrfs

`nixos-pc` expects one btrfs partition (`nvme0n1p6`) with these subvolumes:

| Subvolume | Mount point | Options |
|---|---|---|
| `@` | `/` | `noatime,compress=zstd` |
| `@home` | `/home` | `noatime,compress=zstd` |
| `@nix` | `/nix` | `noatime,compress=zstd` |
| `@log` | `/var/log` | `noatime,compress=zstd` |
| `@swap` | `/swap` | `noatime` (swapfiles must not be compressed) |

`/boot` is the ESP on `nvme0n1p5`; Windows has its own ESP on `p1`. Leave the Windows partitions
(`p1`–`p4`) and `p7`/`p8` alone.

Both partitions are mounted by label (`nixos` and `boot`), so reformatting them needs no config change.
No other partition may carry those labels.

One value only exists after formatting, so the config leaves it `null` and the build fails until it is
set: `resumeOffset` in `modules/hosts/nixos-pc/features/suspend-hibernate.nix`, the physical offset of
the swapfile.

## Before

Formatting `p6` erases `/home`. Copy these to a USB drive first:

- a `secrets.tar.gz` of `~/.ssh`, `~/.gnupg`, `~/.local/share/keyrings`, the KeePass database and
  Syncthing's `cert.pem`, `key.pem` and `config.xml` (in `~/.local/state/syncthing`), so the machine keeps
  its Syncthing device ID;
- a `claude.tar.gz` of the parts of `~/.claude` worth keeping (`CLAUDE.md`, `settings.json`, `hooks/`,
  `agents/`, `rules/`, `projects/*/memory/`);
- anything the browsers do not sync (bookmarks, passwords).

Push this repository and `~/.dotfiles`.

## Install

From the NixOS installer, as root.

### 1. SSH key for root

The private inputs (`unda`, `fcitx5-jot`, `keywave`, `jon`) are fetched over SSH (`git+ssh://`), and
`nixos-install` runs as root. Give root the backed-up key, with `known_hosts`: Nix does not prompt for an
unknown host key, so the fetch fails with `Host key verification failed` without it.

```sh
nix-shell -p git
mkdir -p /media/usb && mount /dev/sdX1 /media/usb    # the USB drive
mkdir -p /tmp/sec && tar xzf /media/usb/secrets.tar.gz -C /tmp/sec
mkdir -p /root/.ssh && cp /tmp/sec/.ssh/{id_ed25519,id_ed25519.pub,known_hosts} /root/.ssh/
chmod 700 /root/.ssh && chmod 600 /root/.ssh/id_ed25519
ssh -T git@github.com
```

Without a backup, create a key with `gh auth login` as in the README.

### 2. Format and mount

```sh
mkfs.fat -F 32 -n boot /dev/nvme0n1p5
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
```

### 3. Clone and set the resume offset

Clone the branch that has the btrfs layout (`feat/btrfs` until it is merged into `main`):

```sh
mkdir -p /mnt/home/hiepnh
git clone -b feat/btrfs https://github.com/justanoobcoder/nixcfg /mnt/home/hiepnh/.nixcfg
cd /mnt/home/hiepnh/.nixcfg

off=$(btrfs inspect-internal map-swapfile -r /mnt/swap/swapfile)
sed -i "s/resumeOffset = null;/resumeOffset = $off;/" modules/hosts/nixos-pc/features/suspend-hibernate.nix
git diff
```

### 4. Install

```sh
nixos-install --flake /mnt/home/hiepnh/.nixcfg#nixos-pc \
  --option extra-substituters "https://justanoobcoder.cachix.org https://umbriel.cachix.org https://cache.lantian.pub/lantian https://noctalia.cachix.org" \
  --option extra-trusted-public-keys "justanoobcoder.cachix.org-1:D2/vJZSn8o8Fpsxzbjc9tHo2/D1ejBUqc4r71UvDVyk= umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw= lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ= noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
nixos-enter --root /mnt -c 'passwd hiepnh'
```

The binary caches in `nix.settings` only take effect once the new system is running, so pass them to
`nixos-install`; without them the CachyOS kernel and the `justanoobcoder/*` packages build from source.

### 5. Restore the backup, then reboot

Restore before the first boot: home-manager starts Syncthing at the first login, and without its old keys
it creates a new device ID.

```sh
tar xzf /media/usb/secrets.tar.gz -C /mnt/home/hiepnh
mkdir -p /mnt/home/hiepnh/.claude
tar xzf /media/usb/claude.tar.gz -C /mnt/home/hiepnh/.claude
nixos-enter --root /mnt -c 'chown -R hiepnh:users /home/hiepnh && chmod 700 /home/hiepnh/.ssh /home/hiepnh/.gnupg'
reboot
```

### 6. After the first boot

As `hiepnh`:

```sh
nixos-rebuild switch --flake ~/.nixcfg#nixos-pc --sudo
git clone -b nixos git@github.com:justanoobcoder/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

`install.sh` links the dotfiles into `$HOME`; it runs after the rebuild so home-manager has created
`~/.config/fish` first.

Run it before the desktop session starts fcitx5: fcitx5 creates its own `~/.config/fcitx5` on first launch, and
`install.sh` never replaces an existing path, so it only prints `skip ~/.config/fcitx5: already exists`. If that
happens, quit fcitx5, move the directory away (`mv ~/.config/fcitx5 ~/.config/fcitx5.bak`), run `install.sh` again
and restart fcitx5.

Wi-Fi passwords, Tailscale (`tailscale up`), Bluetooth pairings and Cloudflare WARP live outside `/home`
and are set up again by hand.

## Check

- `lsblk -o NAME,LABEL` shows `boot` on `p5` and `nixos` on `p6`, and no other partition with either label.
- `findmnt -t btrfs` lists the five subvolumes.
- `swapon --show` lists `/swap/swapfile`.
- `nix shell nixpkgs#compsize -c sudo compsize /nix` shows how well the store compresses.
- `systemctl list-timers 'btrfs-scrub*'` shows the monthly scrub.
- `syncthing cli show system | grep myID` shows the old device ID.
