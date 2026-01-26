{pkgs, ...}: let
  fcitx5-vmk = pkgs.callPackage ../../../pkgs/fcitx5-vmk/default.nix {};
in {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.qt6Packages.fcitx5-unikey
          fcitx5-vmk
        ];
        waylandFrontend = true;
      };
    };
  };
}
