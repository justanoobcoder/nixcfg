# My NixOS Configuration

This repository contains my personal NixOS configuration, structured using a **dendritic pattern** powered by [`flake-parts`](https://flake.parts) and [`import-tree`](https://github.com/vic/import-tree).

This architecture allows for modular evaluation of standard flake outputs, splitting features, overlays, packages, and host configurations into distinct files that are elegantly discovered through `import-tree` rather than manually maintained arrays of imports.

## Project Structure

Here is the high-level tree structure of the repository:

<details>
<summary>Full Directory Tree</summary>

```text
.
├── modules
│   ├── common
│   │   ├── features
│   │   │   ├── bundles
│   │   │   │   ├── core-system.nix
│   │   │   │   ├── desktop.nix
│   │   │   │   └── dev.nix
│   │   │   ├── home-manager
│   │   │   │   ├── default.nix
│   │   │   │   ├── hm-foot.nix
│   │   │   │   ├── hm-git.nix
│   │   │   │   ├── hm-hypridle.nix
│   │   │   │   ├── hm-keywave.nix
│   │   │   │   ├── hm-syncthing.nix
│   │   │   │   └── hm-udiskie.nix
│   │   │   ├── allow-unfree.nix
│   │   │   ├── appimage.nix
│   │   │   ├── artcraft.nix
│   │   │   ├── battery.nix
│   │   │   ├── bluetooth.nix
│   │   │   ├── cachyos-kernel.nix
│   │   │   ├── cloudflare-warp.nix
│   │   │   ├── distrobox-podman.nix
│   │   │   ├── docker.nix
│   │   │   ├── fish.nix
│   │   │   ├── fonts.nix
│   │   │   ├── gnupg.nix
│   │   │   ├── hyprland.nix
│   │   │   ├── network-manager.nix
│   │   │   ├── niri.nix
│   │   │   ├── noctalia-greeter.nix
│   │   │   ├── noctalia.nix
│   │   │   ├── numlock.nix
│   │   │   ├── nvidia.nix
│   │   │   ├── openssh.nix
│   │   │   ├── optimise-disk.nix
│   │   │   ├── overlays.nix
│   │   │   ├── sound.nix
│   │   │   ├── swap-capslk-esc.nix
│   │   │   ├── sysrq.nix
│   │   │   ├── systemd-boot.nix
│   │   │   ├── tts.nix
│   │   │   ├── udisks2.nix
│   │   │   ├── umbriel.nix
│   │   │   ├── vietnamese-input-method.nix
│   │   │   ├── zoxide.nix
│   │   │   └── zsh.nix
│   │   ├── overlays
│   │   │   ├── fastfetch.nix
│   │   │   ├── fcitx5-areca.nix
│   │   │   ├── gpu-screen-recorder.nix
│   │   │   ├── ladybird.nix
│   │   │   └── pyopenjtalk-plus.nix
│   │   └── packages
│   │       ├── areca-ime.nix
│   │       └── keywave.nix
│   ├── hosts
│   │   └── nixos-pc
│   │       ├── features
│   │       │   ├── firewall.nix
│   │       │   ├── sudo-no-pass.nix
│   │       │   └── suspend-hibernate.nix
│   │       ├── home
│   │       │   └── hiepnh
│   │       │       ├── default.nix
│   │       │       ├── hm-env.nix
│   │       │       ├── hm-fish.nix
│   │       │       ├── hm-java.nix
│   │       │       └── hm-xdg.nix
│   │       ├── configuration.nix
│   │       ├── default.nix
│   │       ├── hardware.nix
│   │       ├── packages.nix
│   │       └── user.nix
│   └── parts.nix
├── flake.lock
├── flake.nix
```
</details>

## Directory Purposes

### `/flake.nix` & `/flake.lock`
The entry point of the configuration. It defines inputs (like `nixpkgs`, `home-manager`, `flake-parts`, `import-tree`, etc.) and delegates the output structure generation to `import-tree ./modules`.

### `/modules/`
The root directory imported by `import-tree`, mapped directly into flake outputs based on the folder hierarchy.

#### `/modules/common/`
Global configurations, packages, and overlays that can be reused across any machine/host.

* **`/modules/common/features/`**: Standalone module definitions for system services and configurations like Docker, Bluetooth, SSH, Fonts, etc. Each file controls a specific aspect of the system.
* **`/modules/common/features/bundles/`**: Curated logical collections of features (e.g., `core-system.nix`, `niri-desktop.nix`) imported together to drastically simplify host definitions.
* **`/modules/common/features/home-manager/`**: User-level application configurations managed via `home-manager` (e.g., git, tmux, zsh).
* **`/modules/common/overlays/`**: Custom overrides modifying standard derivation attributes within the `nixpkgs` set.
* **`/modules/common/packages/`**: Custom local packages that are not available in upstream repopsitories, packaged via derivations to be exposed by the flake.

#### `/modules/hosts/`
Contains machine-specific configurations (e.g., desktops, laptops, servers).

* **`/modules/hosts/nixos-pc/`**: Configuration uniquely declaring the setup for the host `nixos-pc`.
  * **`.../features/`**: Machine-specific behaviors/quirks enabled solely on this host (like custom suspend modes or sudo configurations).
  * **`.../hardware.nix`**: Generated or specified hardware configuration for this specific system.
  * **`.../home/hiepnh/`**: User-specific configuration entry point integrating `home-manager` settings tailored for the `hiepnh` user on this machine.
  * **`.../configuration.nix` & `.../packages.nix` & `.../user.nix`**: Further logically separated host configuration chunks composing the system closure.

### `/modules/parts.nix`
This file likely ties the dendritic structure into `flake-parts`, resolving how different pieces map to final flake attributes like `nixosConfigurations`.

## Installing on a New Machine

Some flake inputs (`fcitx5-jot`, `jotty`) are **private GitHub repositories** fetched over SSH, so the installer needs an SSH key registered on GitHub before it can evaluate the flake. Prebuilt binaries of these packages are served from [`justanoobcoder.cachix.org`](https://app.cachix.org/cache/justanoobcoder), so they are downloaded instead of rebuilt (as long as the cache was pushed after the last rebuild).

The steps below work from the **minimal (no desktop) NixOS ISO**. GitHub login uses the device flow, so you only need a phone or another device with a browser.

### 1. Prepare the live environment

Boot the ISO, connect to the network, then become root (`nixos-install` runs as root, so the SSH key must belong to root):

```sh
sudo -i
nix-shell -p gh git
```

### 2. Authenticate with GitHub

```sh
gh auth login
```

Answer the prompts:

- **Where do you use GitHub?** → `GitHub.com`
- **Preferred protocol for Git operations?** → `SSH`
- **Generate a new SSH key?** → `Yes` (optionally set a passphrase)
- **Title for your SSH key** → something identifiable, e.g. `nixos-installer`
- **How would you like to authenticate?** → `Login with a web browser`

`gh` prints a one-time code. Open <https://github.com/login/device> on your phone, enter the code and approve. `gh` then uploads the new public key to your GitHub account.

Verify:

```sh
ssh -T git@github.com
```

### 3. Partition, format and mount

Partition and mount the target disk under `/mnt` as usual (see the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning)).

### 4. Clone the configuration

```sh
mkdir -p /mnt/home/hiepnh
git clone git@github.com:justanoobcoder/nixcfg.git /mnt/home/hiepnh/.nixcfg
```

`pleamar` is still a local `path:` input, so clone it to the path referenced in `flake.nix` **inside the live environment** (or temporarily disable `hm-pleamar` for the first install):

```sh
git clone https://github.com/k4ditano/pleamar.git /home/hiepnh/Projects/experiments/pleamar
```

### 5. Update the hardware configuration

If the hardware differs from the previous machine, regenerate it and merge the relevant parts (filesystems, kernel modules, etc.) into `modules/hosts/nixos-pc/hardware.nix`:

```sh
nixos-generate-config --root /mnt --show-hardware-config
```

### 6. Install

```sh
nixos-install --flake /mnt/home/hiepnh/.nixcfg#nixos-pc
```

Set the root password when prompted, then set the user password:

```sh
nixos-enter --root /mnt -c 'passwd hiepnh'
```

### 7. Keep the SSH key (optional)

The key generated in step 2 lives in the live environment's RAM and is lost on reboot. Either copy it to the new system:

```sh
mkdir -p /mnt/home/hiepnh/.ssh
cp ~/.ssh/id_ed25519* /mnt/home/hiepnh/.ssh/
nixos-enter --root /mnt -c 'chown -R hiepnh:users /home/hiepnh/.ssh /home/hiepnh/.nixcfg && chmod 600 /home/hiepnh/.ssh/id_ed25519'
```

Or, after rebooting, run `gh auth login` again as `hiepnh` to create a new key, and delete the `nixos-installer` key from <https://github.com/settings/keys>.

### 8. Rebuilding afterwards

Run rebuilds as your user (not `sudo nixos-rebuild`) so private inputs are fetched with your own SSH key:

```sh
nixos-rebuild switch --flake ~/.nixcfg#nixos-pc --sudo
```

### Updating the binary cache

After updating the private inputs (or `nixpkgs`) and rebuilding, push the new builds so the next reinstall can download them:

```sh
nix path-info -r /run/current-system | grep -E 'jot|pleamar' | grep -v -- '-source$'
cachix push justanoobcoder <store paths of the main packages>
```
