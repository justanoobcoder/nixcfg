{
  flake.nixosModules.systemdBoot = _: {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
        efi = {
          canTouchEfiVariables = true;
        };
      };
    };
  };
}
