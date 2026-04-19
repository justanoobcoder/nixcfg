{self, ...}: {
  flake.niriDesktopBundle = {
    nixosModules = _: {
      imports = [
        self.nixosModules.niri
        self.nixosModules.fonts
        self.nixosModules.dms
        self.nixosModules.sound
        self.nixosModules.bluetooth
        self.nixosModules.vietnameseInputMethod
        self.nixosModules.swapCapslkEsc
        self.nixosModules.appimage
        self.nixosModules.gnupg
        self.nixosModules.udisks2
        self.nixosModules.tts
      ];
    };

    homeModules = _: {
      imports = [
        self.homeModules.wayvibes
        self.homeModules.udiskie
        self.homeModules.hypridle
        self.homeModules.jcm
      ];
    };
  };
}
