{ inputs, ... }:
{
  flake.nixosModules.vietnameseInputMethod = _: {
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
          waylandFrontend = true;
        };
      };
    };
  };
}
