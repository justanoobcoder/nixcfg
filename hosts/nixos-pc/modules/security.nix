{pkgs, ...}: {
  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/current-system/sw/bin/nvim";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/current-system/sw/bin/nix";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/current-system/sw/bin/nix-collect-garbage";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/wrappers/bin/mount";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
        {
          command = "/run/wrappers/bin/umount";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
      ];
    }
  ];

  security.wrappers."gsr-kms-server" = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
  };
}
