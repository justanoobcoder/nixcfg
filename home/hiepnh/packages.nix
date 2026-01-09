{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    discord
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
    qogir-icon-theme

    # custom packages
    inputs.self.packages.${stdenv.hostPlatform.system}.keypop
    inputs.self.packages.${stdenv.hostPlatform.system}.wlctl

    # packages from outside of nixpkgs
    inputs.zalo.packages.${stdenv.hostPlatform.system}.default
  ];
}
