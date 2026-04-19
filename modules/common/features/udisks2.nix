{
  flake.nixosModules.udisks2 = _: {
    services.udisks2.enable = true;
  };
}
