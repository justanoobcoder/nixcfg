{ inputs, ... }: {
  flake.nixosModules.umbriel = _: {
    imports = [ inputs.umbriel.nixosModules.default ];

    programs.umbriel.enable = true;
  };
}
