{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos-pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};

    modules = [
      inputs.agenix.nixosModules.default

      self.nixosModules.nixosPcConfiguration
      self.nixosModules.homeManager

      self.coreSystemBundle.nixosModules
      self.devBundle.nixosModules
      self.niriDesktopBundle.nixosModules

      self.nixosModules.tuigreet
      self.nixosModules.zsh
      self.nixosModules.fish
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.nvidia
      self.nixosModules.hyprland
    ];
  };
}
