{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./programs
    ./packages.nix
    ./theme.nix
    ./xdg.nix
  ];

  home.username = "hiepnh";
  home.homeDirectory = "/home/hiepnh";

  # For some reasons, this service will not start if put it in a seperate module,
  # so it must stay here
  services.syncthing.enable = true;

  home.stateVersion = "25.11";
}
