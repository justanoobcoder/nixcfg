{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos-pc";

  nixpkgs.config.allowUnfree = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.zsh = {
    enable = true;
    shellInit = "export ZDOTDIR=/home/hiepnh/.config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  users.users.hiepnh = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "input" "power" "audio" "video" "networkmanager" ];
    packages = with pkgs; [];
  };

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [pkgs.qt6Packages.fcitx5-unikey];
        waylandFrontend = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    gcc15
    gnutar
    unzip
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
