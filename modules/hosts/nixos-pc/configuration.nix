{self, ...}: {
  flake.nixosModules.nixosPcConfiguration = _: {
    imports = [
      self.nixosModules.nixosPcHardware
      self.nixosModules.hiepnhUser
      self.nixosModules.packages
      self.nixosModules.sudoNoPass
      self.nixosModules.suspendHibernate
    ];

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "hiepnh"];

      substituters = [
        "https://justanoobcoder.cachix.org"
      ];
      trusted-public-keys = [
        "justanoobcoder.cachix.org-1:D2/vJZSn8o8Fpsxzbjc9tHo2/D1ejBUqc4r71UvDVyk="
      ];
    };

    time.timeZone = "Asia/Ho_Chi_Minh";

    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "nixos-pc";

    age.secrets = {
      cachixAuthToken = {
        file = ./secrets/cachix-auth-token.age;
        owner = "hiepnh";
        mode = "0400";
      };
    };

    environment.sessionVariables = {
      EDITOR = "nvim";
    };

    home-manager.users.hiepnh = self.homeModules.hiepnhModule;

    system.stateVersion = "26.05";
  };
}
