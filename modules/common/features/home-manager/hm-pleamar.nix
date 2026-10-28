{ inputs, ... }: {
  flake.homeModules.hmPleamar = _: {
    imports = [ inputs.pleamar.homeManagerModules.default ];

    programs.pleamar = {
      enable = true;
      autostart = true; # runs ~/.config/pleamar/autostart with your graphical session
    };
  };
}
