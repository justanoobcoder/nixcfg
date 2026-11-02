{
  flake.homeModules.hmFoot = _: {
    programs.foot = {
      enable = true;
      server.enable = false;
    };
  };
}
