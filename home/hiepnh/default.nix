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

  home = {
    username = "hiepnh";
    homeDirectory = "/home/hiepnh";
    stateVersion = "25.11";
  };
}
