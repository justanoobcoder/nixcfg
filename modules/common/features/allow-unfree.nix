{
  flake.nixosModules.allowUnfree = _: {
    nixpkgs.config.allowUnfree = true;
  };
}
