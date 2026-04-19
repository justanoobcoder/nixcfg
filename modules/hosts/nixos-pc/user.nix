{
  flake.nixosModules.hiepnhUser = {pkgs, ...}: {
    users.users.hiepnh = {
      isNormalUser = true;
      shell = pkgs.zsh;
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
