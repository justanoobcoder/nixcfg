{ inputs, ... }: {
  flake.nixosModules.umbriel = _: {
    imports = [ inputs.umbriel.nixosModules.default ];

    nix.settings = {
      extra-substituters = [ "https://umbriel.cachix.org" ];
      extra-trusted-public-keys = [
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };

    programs.umbriel.enable = true;
  };
}
