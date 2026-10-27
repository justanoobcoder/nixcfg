{ inputs, ... }: {
  flake.nixosModules.artcraft = _: {
    imports = [
      inputs.nix-craftapps.nixosModules.default
    ];

    programs.craftapps = {
      enable = true;
      apps = {
        photocraft.enable = true;
        pdfcraft.enable = true;
        wordcraft.enable = true;
        gridcraft.enable = true;
        deckcraft.enable = true;
      };
    };
  };
}
