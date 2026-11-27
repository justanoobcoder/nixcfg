{
  flake.nixosModules.nixosPcConfiguration = _: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    networking.hostName = "nixos-pc";

    nixcfg.primaryUser = "hiepnh";

    nixpkgs.config.permittedInsecurePackages = [
      "electron-40.10.5"
    ];

    system.stateVersion = "26.05";
  };
}
