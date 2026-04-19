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

      self.coreSystemBundle.nixosModules
      self.devBundle.nixosModules
      self.niriDesktopBundle.nixosModules

      self.nixosModules.zsh
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.nvidia
    ];
  };
}
