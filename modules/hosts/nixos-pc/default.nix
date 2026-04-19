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
      self.nixosModules.fonts
      self.nixosModules.niri
      self.nixosModules.dms
      self.nixosModules.sound
      self.nixosModules.swapCapslkEsc
      self.nixosModules.vietnameseInputMethod
      self.nixosModules.docker
      self.nixosModules.systemdBoot
      self.nixosModules.cachyosKernel
      self.nixosModules.sysrq
      self.nixosModules.networkManager
      self.nixosModules.zsh
      self.nixosModules.zoxide
      self.nixosModules.battery
      self.nixosModules.openssh
      self.nixosModules.appimage
      self.nixosModules.bluetooth
      self.nixosModules.udisks2
      self.nixosModules.cloudflareWarp
      self.nixosModules.gnupg
      self.nixosModules.optimiseDisk
      self.nixosModules.tts
      self.nixosModules.nvidia
    ];
  };
}
