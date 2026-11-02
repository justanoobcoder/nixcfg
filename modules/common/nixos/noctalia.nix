{ inputs, ... }: {
  flake.nixosModules.noctalia = _: {
    imports = [
      inputs.noctalia.nixosModules.default
    ];

    nix.settings = {
      substituters = [ "https://noctalia.cachix.org" ];
      trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    programs.noctalia = {
      enable = true;
      systemd.enable = false;
      recommendedServices.enable = true;
    };
  };
}
