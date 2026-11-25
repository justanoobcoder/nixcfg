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
      self.nixosModules.networkManager
      self.nixosModules.cloudflareWarp
    ];

    # graphical-desktop enables speechd by default; it pulls in ~0.7 GB of mbrola voices.
    services.speechd.enable = false;
  };

  flake.homeModules.bundleDesktop = _: {
    imports = [
      self.homeModules.hmFoot
      self.homeModules.hmJotty
      self.homeModules.hmJon
      self.homeModules.hmUdiskie
    ];
  };
}
