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
      self.nixosModules.nixosPcNtfy

      # common
      self.nixosModules.unda
      self.nixosModules.homeManager

      self.nixosModules.bundleCoreSystem
      self.nixosModules.bundleDev
      self.nixosModules.bundleDesktop

      self.nixosModules.umbriel
      self.nixosModules.zsh
      self.nixosModules.fish
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.intelGraphics
      self.nixosModules.nvidia
      self.nixosModules.artcraft
      # Disabled: dwarfs 0.15.8 (needed to unpack the Zalo AppImage) fails its tests on current nixpkgs.
      # self.nixosModules.zalo
    ];
  };
}
