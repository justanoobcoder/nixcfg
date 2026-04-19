{
  flake.nixosModules.networkManager = _: {
    networking.networkmanager.enable = true;
  };
}
