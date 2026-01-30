{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.fcitx5-vmk.nixosModules.fcitx5-vmk
  ];

  services.fcitx5-vmk = {
    enable = true;
    user = "hiepnh";
  };

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        # addons = [
        #   pkgs.qt6Packages.fcitx5-unikey
        # ];
        waylandFrontend = true;
      };
    };
  };
}
