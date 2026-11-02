{ self, ... }:
{
  flake.nixosModules.bundleCoreSystem = _: {
    imports = [
      self.nixosModules.systemdBoot
      self.nixosModules.cachyosKernel
      self.nixosModules.sysrq
      self.nixosModules.optimiseDisk
      self.nixosModules.allowUnfree
      self.nixosModules.overlays
    ];
  };
}
