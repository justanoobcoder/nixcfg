{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # desktop
        adw-gtk3
        antigravity-ide
        bibata-cursors
        brightnessctl
        brave
        firefox
        godot
        gpu-screen-recorder
        grim
        hyprpicker
        imv
        keepassxc
        kdePackages.qt6ct
        libsForQt5.qt5ct
        libresprite
        localsend
        lutris
        mpv
        obs-studio
        playerctl
        postman
        ripdrag
        slurp
        swappy
        telegram-desktop
        tela-circle-icon-theme
        tiled
        vesktop
        wl-clipboard

        # cli
        bat
        btop
        cachix
        claude-code
        curl
        devenv
        e2fsprogs
        eza
        fastfetch
        fd
        fzf
        gh
        git
        gnutar
        hw-probe
        inetutils
        jq
        killall
        lazygit
        nh
        nix-update
        nixpkgs-review
        python3
        ripgrep
        starship
        stow
        tree
        tree-sitter
        unrar
        unzip
        usbutils
        wget
        yazi
        zellij
        zoxide

        # custom packages
        self.packages.${pkgs.stdenv.hostPlatform.system}.keywave

        # others
        inputs.fcitx5-jot.packages.${pkgs.stdenv.hostPlatform.system}.jot-settings
        inputs.jotty.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.wayshadow.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
