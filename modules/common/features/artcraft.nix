{ inputs, ... }: {
  flake.nixosModules.artcraft = _: {
    imports = [
      inputs.nix-craftapps.nixosModules.default
    ];

    programs.craftapps = {
      enable = true;
      apps = {
        pdfcraft.enable = true;
        wordcraft.enable = true;
      };
    };
  };
}
