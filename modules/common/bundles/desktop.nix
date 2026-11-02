{ self, ... }:
{
  flake.nixosModules.bundleDesktop = _: {
    imports = [
      self.nixosModules.numlock
      self.nixosModules.fonts
      self.nixosModules.noctalia
      self.nixosModules.sound
      self.nixosModules.bluetooth
      self.nixosModules.vietnameseInputMethod
      self.nixosModules.swapCapslkEsc
      self.nixosModules.appimage
      self.nixosModules.udisks2
      self.nixosModules.tts
      self.nixosModules.networkManager
      self.nixosModules.cloudflareWarp
    ];
  };

  flake.homeModules.bundleDesktop = _: {
    imports = [
      self.homeModules.hmFoot
      self.homeModules.hmUdiskie
      self.homeModules.hmHypridle
    ];
  };
}
