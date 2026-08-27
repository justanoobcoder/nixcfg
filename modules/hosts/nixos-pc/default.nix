{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.nixos-pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };

    modules = [
      self.nixosModules.nixosPcConfiguration
      self.nixosModules.homeManager

      self.coreSystemBundle.nixosModules
      self.devBundle.nixosModules
      self.desktopBundle.nixosModules

      self.nixosModules.umbriel
      self.nixosModules.noctaliaGreeter
      self.nixosModules.zsh
      self.nixosModules.fish
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.nvidia
    ];
  };
}
