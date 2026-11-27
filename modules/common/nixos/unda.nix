{ inputs, ... }: {
  flake.nixosModules.unda = { config, ... }: {
    imports = [ inputs.unda.nixosModules.default ];

    programs.unda = {
      enable = true;
      systemd.enable = true;
      greeter = {
        enable = true;
        syncUser = config.nixcfg.primaryUser;
      };
    };
  };
}
