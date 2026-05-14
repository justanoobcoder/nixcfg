{
  lib,
  self,
  ...
}:
{
  flake.nixosModules.overlays = {
    nixpkgs.overlays = lib.attrValues self.overlays;
  };
}
