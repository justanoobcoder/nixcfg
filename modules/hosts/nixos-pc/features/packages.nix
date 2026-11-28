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
        bibata-cursors
        brightnessctl
        godot
        gpu-screen-recorder
        imv
        keepassxc
        kdePackages.breeze-icons
        kdePackages.qt6ct
        ladybird
        libsForQt5.qt5ct
        lutris
        mpv
        playerctl
        tela-circle-icon-theme
        vesktop
        wl-clipboard

        # cli
        cachix
        claude-code
        eza
        fastfetch
        fd
        fzf
        gh
        git
        jq
        killall
        lazygit
        python3
        ripgrep
        starship
        yazi
        zellij
        zoxide

        # others
        inputs.self.packages.${system}.disk-hogs
        inputs.antigravity-nix.packages.${system}.google-antigravity-ide
        inputs.fcitx5-jot.packages.${system}.jot-settings
        inputs.jotty.packages.${system}.default
        inputs.helium.packages.${system}.default
        inputs.keywave.packages.${system}.default
        inputs.luciole.packages.${system}.default
        inputs.noobvim.packages.${system}.default
      ];
    };
}
