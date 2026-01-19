{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # desktop
    discord
    kitty
    app2unit
    vicinae
    pcmanfm-qt
    telegram-desktop
    obs-studio
    keepassxc
    syncthing
    qogir-icon-theme
    hypridle
    brightnessctl
    easyeffects
    gimp
    grim
    slurp
    tesseract
    gpu-screen-recorder
    obsidian
    libnotify
    jetbrains.rust-rover
    jetbrains.idea-oss
    kdePackages.qt6ct
    libsForQt5.qt5ct
    adw-gtk3
    tela-circle-icon-theme

    # cli
    yazi
    fastfetch
    starship
    lazygit
    stow
    tree-sitter
    eza
    fzf
    amber-lang
    btop

    # custom packages
    inputs.self.packages.${stdenv.hostPlatform.system}.keypop
    inputs.self.packages.${stdenv.hostPlatform.system}.wlctl

    # packages from outside of nixpkgs
    inputs.zalo.packages.${stdenv.hostPlatform.system}.default
    inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
