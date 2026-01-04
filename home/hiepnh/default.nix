{ config, pkgs, inputs, ... }:

{
  imports = [ ../common ];

  home.username = "hiepnh";
  home.homeDirectory = "/home/hiepnh";

  home.packages = with pkgs; [
    app2unit
    firefox
    kitty
    stow
    vicinae
    eza
    fzf
    fastfetch
    starship
    zoxide
    lazygit
    tree-sitter
    ripgrep
    fd
    nerd-fonts.jetbrains-mono
    amber-lang
    tmux
    mpv
    imv
    thunar
    noto-fonts
    noto-fonts-color-emoji
    liberation_ttf
    font-awesome
    inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.with-cli
    inputs.hyprshutdown.packages.${stdenv.hostPlatform.system}.hyprshutdown
    flameshot
  ];

  programs = {
    git = {
      enable = true;
      settings.user.name = "Nguyen Hong Hiep";
      settings.user.email = "syaorancode@gmail.com";
      settings = {
        init.defaultBranch = "main";
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  home.stateVersion = "25.11";
}
