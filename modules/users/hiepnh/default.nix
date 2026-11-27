{ self, ... }:
{
  # Everything a host needs to have hiepnh: the account and its home-manager config.
  flake.nixosModules.userHiepnh =
    { pkgs, ... }:
    {
      users.users.hiepnh = {
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "input"
          "power"
          "audio"
          "video"
          "networkmanager"
          "uinput"
        ];
      };

      nix.settings.trusted-users = [ "hiepnh" ];

      home-manager.users.hiepnh = self.homeModules.userHiepnh;
    };
}
