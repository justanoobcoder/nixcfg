{
  pkgs,
  inputs,
  ...
}: let
  platform = pkgs.stdenv.hostPlatform.system;
in {
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
    lutris

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
    devenv

    # custom packages
    custom.keypop
    custom.wlctl

    # packages from outside of nixpkgs
    inputs.noobvim.packages.${platform}.default
  ];
}
