{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./programs
    ./packages.nix
    ./theme.nix
    ./xdg.nix
    ./services.nix
    ./input.nix
  ];

  home.username = "hiepnh";
  home.homeDirectory = "/home/hiepnh";

  home.stateVersion = "25.11";
}
