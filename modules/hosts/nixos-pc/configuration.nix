{ self, ... }:
{
  flake.nixosModules.nixosPcConfiguration = _: {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "hiepnh" ];

      substituters = [
        "https://justanoobcoder.cachix.org"
      ];
      trusted-public-keys = [
        "justanoobcoder.cachix.org-1:D2/vJZSn8o8Fpsxzbjc9tHo2/D1ejBUqc4r71UvDVyk="
      ];
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    time.timeZone = "Asia/Ho_Chi_Minh";

    i18n.defaultLocale = "en_US.UTF-8";

    networking.hostName = "nixos-pc";

    environment.sessionVariables = {
      EDITOR = "nvim";
    };

    nixpkgs.config.permittedInsecurePackages = [
      "electron-40.10.5"
    ];

    home-manager.users.hiepnh = self.homeModules.nixosPcHiepnh;

    system.stateVersion = "26.05";
  };
}
