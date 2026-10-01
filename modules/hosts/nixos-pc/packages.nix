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
        app2unit
        bibata-cursors
        brightnessctl
        brave
        firefox
        gimp
        godot
        gpu-screen-recorder
        grim
        hyprpicker
        imv
        keepassxc
        kdePackages.okular
        kdePackages.qt6ct
        kitty
        ladybird
        libsForQt5.qt5ct
        libresprite
        localsend
        lutris
        mpv
        obs-studio
        pcmanfm-qt
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
        amber-lang
        bat
        bear
        btop
        cachix
        codex
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
        ripgrep
        starship
        stow
        tree
        tree-sitter
        unzip
        usbutils
        wget
        yazi
        zellij
        zoxide

        # custom packages
        self.packages.${pkgs.stdenv.hostPlatform.system}.keywave

        # others
        inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.wayshadow.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
