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
    wtype
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
    gpu-screen-recorder
    obsidian
    kdePackages.qt6ct
    libsForQt5.qt5ct
    adw-gtk3
    tela-circle-icon-theme
    antigravity
    lutris
    blobdrop
    # hyprshutdown
    zed-editor-fhs
    showmethekey
    kdePackages.okular
    jetbrains-toolbox

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
    nh
    jdk21_headless
    maven

    # custom packages
    custom.keypop
    custom.wlctl

    # packages from outside of nixpkgs
    inputs.noobvim.packages.${platform}.default
    inputs.wayscriber.packages.${platform}.default
  ];
}
