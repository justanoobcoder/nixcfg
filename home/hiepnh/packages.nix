{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    stow
    vicinae
    brightnessctl
    eza
    fzf
    fastfetch
    starship
    lazygit
    tree-sitter
    ripgrep
    fd
    amber-lang
    thunar
    app2unit
    flameshot
    telegram-desktop
    obs-studio
    keepassxc
    btop
    syncthing
    # nixd
    # alejandra

    # custom packages
    inputs.self.packages.${stdenv.hostPlatform.system}.keypop
    inputs.self.packages.${stdenv.hostPlatform.system}.wlctl

    # packages from outside of nixpkgs
    inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.with-cli
    inputs.hyprshutdown.packages.${stdenv.hostPlatform.system}.hyprshutdown
    inputs.rose-pine-hyprcursor.packages.${stdenv.hostPlatform.system}.default
    inputs.zalo.packages.${stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
