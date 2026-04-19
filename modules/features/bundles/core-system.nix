{self, ...}: {
  flake.coreSystemBundle = {
    nixosModules = _: {
      imports = [
        self.nixosModules.systemdBoot
        self.nixosModules.cachyosKernel
        self.nixosModules.sysrq
        self.nixosModules.optimiseDisk
        self.nixosModules.allowUnfree
        self.nixosModules.swapCapslkEsc
      ];
    };

    homeModules = _: {
      imports = [];
    };
  };
}
