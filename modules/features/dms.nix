{
  flake.nixosModules.dms = _: {
    programs.dms-shell = {
      enable = true;
    };
  };
}
