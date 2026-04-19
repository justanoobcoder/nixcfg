{inputs, ...}: {
  flake.homeModules.jcm = _: {
    imports = [inputs.jcm.homeManagerModules.default];
    programs.jcm.enable = true;
  };
}
