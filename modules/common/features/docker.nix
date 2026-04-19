{
  flake.nixosModules.docker = _: {
    virtualisation = {
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
    };
  };
}
