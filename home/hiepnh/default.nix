{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common
    ./packages.nix
    ./theme.nix
    ./xdg.nix
  ];

  home.username = "hiepnh";
  home.homeDirectory = "/home/hiepnh";

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

  home.stateVersion = "25.11";
}
