{ inputs, ... }: {
  flake.nixosModules.unda = _: {
    imports = [ inputs.unda.nixosModules.default ];

    programs.unda = {
      enable = true;
      systemd.enable = true;
      greeter = {
        enable = true;
        syncUser = "hiepnh";
      };
    };
  };
}
