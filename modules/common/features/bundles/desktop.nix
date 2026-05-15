{ self, ... }:
{
  flake.desktopBundle = {
    nixosModules = _: {
      imports = [
        self.nixosModules.fonts
        self.nixosModules.dms
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

    homeModules = _: {
      imports = [
        self.homeModules.hmWayvibes
        self.homeModules.hmUdiskie
        self.homeModules.hmHypridle
        self.homeModules.hmJcm
      ];
    };
  };
}
