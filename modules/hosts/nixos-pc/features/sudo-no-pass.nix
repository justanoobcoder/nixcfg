{
  flake.nixosModules.nixosPcSudoNoPass = _: {
    security.sudo.extraRules = [
      {
        groups = [ "wheel" ];
        commands =
          map
            (command: {
              inherit command;
              options = [
                "SETENV"
                "NOPASSWD"
              ];
            })
            [
              "/run/current-system/sw/bin/systemctl"
              "/run/current-system/sw/bin/nvim"
              "/run/current-system/sw/bin/nixos-rebuild"
              "/run/current-system/sw/bin/nix"
              "/run/current-system/sw/bin/nix-collect-garbage"
              "/run/wrappers/bin/mount"
              "/run/wrappers/bin/umount"
              "/run/current-system/sw/bin/efibootmgr"
              "/run/current-system/sw/bin/docker"
            ];
      }
    ];
  };
}
