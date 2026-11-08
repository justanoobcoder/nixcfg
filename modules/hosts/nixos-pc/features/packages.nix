{
  inputs,
  ...
}:
{
  flake.nixosModules.nixosPcPackages =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      environment.systemPackages = with pkgs; [
        # desktop
        adw-gtk3
        antigravity-ide
        bibata-cursors
        brightnessctl
        firefox
        godot
        gpu-screen-recorder
        grim
        imv
        keepassxc
        kdePackages.breeze-icons
        kdePackages.qt6ct
        ladybird
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

        # others
        inputs.fcitx5-jot.packages.${system}.jot-settings
        inputs.jotty.packages.${system}.default
        inputs.helium.packages.${system}.default
        inputs.keywave.packages.${system}.default
        inputs.noobvim.packages.${system}.default
        inputs.wayshadow.packages.${system}.default
      ];
    };
}
