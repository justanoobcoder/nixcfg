{self, ...}: {
  flake.nixosModules.nixosPcConfiguration = _: {
    imports = [
      self.nixosModules.nixosPcHardware
      self.nixosModules.hiepnhUser
      self.nixosModules.packages
      self.nixosModules.sudoNoPass
      self.nixosModules.suspendHibernate
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    time.timeZone = "Asia/Ho_Chi_Minh";

    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "nixos-pc";

    home-manager.users.hiepnh = self.homeModules.hiepnhModule;

    system.stateVersion = "26.05";
  };
}
