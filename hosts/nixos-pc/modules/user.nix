{pkgs, ...}: {
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
      # "libvirtd"
    ];
    packages = [];
  };

  nix.settings.trusted-users = ["root" "hiepnh"];
}
