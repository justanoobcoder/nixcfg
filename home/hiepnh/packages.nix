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
    wl-clipboard
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
    swappy
    tesseract
    gpu-screen-recorder
    obsidian
    jetbrains.rust-rover
    jetbrains.idea-oss
    kdePackages.qt6ct
    libsForQt5.qt5ct
    adw-gtk3
    tela-circle-icon-theme
    antigravity

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
    google-cloud-sdk

    # custom packages
    inputs.self.packages.${stdenv.hostPlatform.system}.keypop
    inputs.self.packages.${stdenv.hostPlatform.system}.wlctl

    # packages from outside of nixpkgs
    inputs.zalo.packages.${stdenv.hostPlatform.system}.default
    inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
