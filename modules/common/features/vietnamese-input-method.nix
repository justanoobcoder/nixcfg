{ inputs, self, ... }:
{
  flake.nixosModules.vietnameseInputMethod = { pkgs, ... }: {
    imports = [
      inputs.fcitx5-lotus.nixosModules.fcitx5-lotus
    ];

    services.fcitx5-lotus = {
      enable = true;
      user = "hiepnh";
    };

    i18n = {
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.fcitx5-areca
          ];
          waylandFrontend = true;
        };
      };
    };
  };
}
