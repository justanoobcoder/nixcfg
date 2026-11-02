{ inputs, ... }: {
  flake.nixosModules.zalo = _: {
    imports = [ inputs.zalo-for-linux.nixosModules.default ];

    programs.zalo = {
      enable = true;
    };
  };
}
