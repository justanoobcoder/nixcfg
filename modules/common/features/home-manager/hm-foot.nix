{
  flake.homeModules.footTerminal = _: {
    programs.foot = {
      enable = true;
      server.enable = true;
    };
  };
}
