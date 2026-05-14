{
  flake.nixosModules.hiepnhUser =
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
          "docker"
        ];
      };
    };
}
