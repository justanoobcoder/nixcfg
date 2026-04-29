{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos-pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.agenix.nixosModules.default

      self.nixosModules.nixosPcConfiguration
      self.nixosModules.homeManager

      self.coreSystemBundle.nixosModules
      self.devBundle.nixosModules
      self.niriDesktopBundle.nixosModules

      self.nixosModules.tuigreet
      self.nixosModules.zsh
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.nvidia
    ];
  };
}
