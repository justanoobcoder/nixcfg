{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./programs
    ./packages.nix
    ./theme.nix
    ./xdg.nix
    ./services.nix
  ];

  home.username = "hiepnh";
  home.homeDirectory = "/home/hiepnh";

  home.stateVersion = "25.11";
}
