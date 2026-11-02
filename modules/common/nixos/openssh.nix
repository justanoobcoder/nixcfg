{
  flake.nixosModules.openssh = _: {
    services.openssh.enable = true;
  };
}
