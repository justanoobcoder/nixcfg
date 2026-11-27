{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.nixos-pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = [
      # host
      self.nixosModules.nixosPcConfiguration
      self.nixosModules.nixosPcHardware
      self.nixosModules.nixosPcPackages
      self.nixosModules.nixosPcSudoNoPass
      self.nixosModules.nixosPcSuspendHibernate
      self.nixosModules.nixosPcFirewall
      self.nixosModules.nixosPcNtfy

      # users
      self.nixosModules.userHiepnh

      # common
      self.nixosModules.bundleBase
      self.nixosModules.bundleCoreSystem
      self.nixosModules.bundleDev
      self.nixosModules.bundleDesktop

      self.nixosModules.unda
      self.nixosModules.umbriel
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.intelGraphics
      self.nixosModules.nvidia
      self.nixosModules.artcraft
      self.nixosModules.zalo
    ];
  };
}
