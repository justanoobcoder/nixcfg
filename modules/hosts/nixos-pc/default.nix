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
      self.nixosModules.nixosPcUser
      self.nixosModules.nixosPcPackages
      self.nixosModules.nixosPcSudoNoPass
      self.nixosModules.nixosPcSuspendHibernate
      self.nixosModules.nixosPcFirewall

      # common
      self.nixosModules.unda
      self.nixosModules.homeManager

      self.nixosModules.bundleCoreSystem
      self.nixosModules.bundleDev
      self.nixosModules.bundleDesktop

      self.nixosModules.umbriel
      self.nixosModules.noctaliaGreeter
      self.nixosModules.zsh
      self.nixosModules.fish
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.nvidia
      self.nixosModules.artcraft
      self.nixosModules.zalo
    ];
  };
}
