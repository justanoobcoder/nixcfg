{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.globalOverlays
      self.nixosModules.nixosPcConfiguration
      self.nixosModules.homeManager
      self.nixosModules.allowUnfree
      self.nixosModules.docker
      self.nixosModules.systemdBoot
      self.nixosModules.cachyosKernel
      self.nixosModules.sysrq
      self.nixosModules.zsh
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.openssh
      self.nixosModules.cloudflareWarp
      self.nixosModules.optimiseDisk
      self.nixosModules.nvidia
      self.nixosModules.gnupg
      self.nixosModules.swapCapslkEsc

      self.niriDesktopBundle.nixosModules
    ];
  };
}
