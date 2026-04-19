{
  lib,
  self,
  ...
}: {
  flake.nixosModules.globalOverlays = {
    nixpkgs.overlays = lib.attrValues self.overlays;
  };
}
