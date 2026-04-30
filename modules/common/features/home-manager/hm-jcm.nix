{inputs, ...}: {
  flake.homeModules.hmJcm = _: {
    imports = [inputs.jcm.homeManagerModules.default];
    programs.jcm.enable = true;
  };
}
