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
    pcmanfm-qt
    wl-clipboard
    wtype
    telegram-desktop
    obs-studio
    keepassxc
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
    code-cursor
    lutris
    blobdrop
    zed-editor-fhs
    showmethekey
    kdePackages.okular
    jetbrains-toolbox
    postman
    winboat

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
    direnv

    # custom packages
    custom.wlctl

    # packages from outside of nixpkgs
    inputs.noobvim.packages.${platform}.default
    inputs.wayscriber.packages.${platform}.default
    inputs.keypop.packages.${platform}.default
  ];
}
