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
        brave
        kitty
        app2unit
        discord
        wl-clipboard
        mpv
        imv
        neovide
        antigravity-ide
        pcmanfm-qt
        telegram-desktop
        obs-studio
        keepassxc
        brightnessctl
        gimp
        grim
        slurp
        swappy
        gpu-screen-recorder
        kdePackages.qt6ct
        libsForQt5.qt5ct
        adw-gtk3
        tela-circle-icon-theme
        lutris
        blobdrop
        kdePackages.okular
        postman
        localsend
        playerctl
        hyprpicker


        # cli
        e2fsprogs
        yazi
        stow
        amber-lang
        btop
        devenv
        nh
        fastfetch
        lazygit
        eza
        starship
        fzf
        killall
        zoxide
        git
        tree
        curl
        wget
        gnutar
        unzip
        bat
        jq
        fd
        ripgrep
        inetutils
        cachix
        hw-probe
        usbutils
        nixpkgs-review
        gh

        # self.packages.${pkgs.stdenv.hostPlatform.system}.wlctl

        inputs.keypop.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.hyprland-scroll-overview.packages.${pkgs.stdenv.hostPlatform.system}.scrolloverview
        inputs.wlctl.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        (inputs.HyprQuickFrame.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace shell.qml --replace-fail '/Pictures' '/xdg/pictures'
            substituteInPlace shell.qml --replace-fail '/Screenshots' '/screenshots'
          '';
        }))
      ];
    };
}
