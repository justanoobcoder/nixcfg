{inputs, ...}: {
  imports = [inputs.jcm.homeManagerModules.default];
  programs.jcm.enable = true;
}
