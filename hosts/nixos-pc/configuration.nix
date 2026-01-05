{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules
    ];

  networking.hostName = "nixos-pc";

  boot.kernel.sysctl."kernel.sysrq" = 1;
  nixpkgs.config.allowUnfree = true;

  # To run AppImage easily
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
