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
│   │   │   │   ├── hm-git.nix
│   │   │   │   ├── hm-hypridle.nix
│   │   │   │   ├── hm-jcm.nix
│   │   │   │   ├── hm-syncthing.nix
│   │   │   │   ├── hm-tmux.nix
│   │   │   │   ├── hm-udiskie.nix
│   │   │   │   └── hm-wayvibes.nix
│   │   │   ├── allow-unfree.nix
│   │   │   ├── appimage.nix
│   │   │   ├── battery.nix
│   │   │   ├── bluetooth.nix
│   │   │   ├── cachyos-kernel.nix
│   │   │   ├── cloudflare-warp.nix
│   │   │   ├── dms.nix
│   │   │   ├── docker.nix
│   │   │   ├── fish.nix
│   │   │   ├── fonts.nix
│   │   │   ├── gnupg.nix
│   │   │   ├── hyprland.nix
│   │   │   ├── network-manager.nix
│   │   │   ├── niri.nix
│   │   │   ├── nvidia.nix
│   │   │   ├── openssh.nix
│   │   │   ├── optimise-disk.nix
│   │   │   ├── overlays.nix
│   │   │   ├── sound.nix
│   │   │   ├── swap-capslk-esc.nix
│   │   │   ├── sysrq.nix
│   │   │   ├── systemd-boot.nix
│   │   │   ├── tts.nix
│   │   │   ├── tuigreet.nix
│   │   │   ├── udisks2.nix
│   │   │   ├── vietnamese-input-method.nix
│   │   │   ├── zoxide.nix
│   │   │   └── zsh.nix
│   │   ├── overlays
│   │   │   ├── fastfetch.nix
│   │   │   └── openldap.nix
│   │   └── packages
│   │       └── wlctl.nix
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
│   │       │       └── hm-xdg.nix
│   │       ├── secrets
│   │       │   ├── cachix-auth-token.age
│   │       │   └── secrets.nix
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
