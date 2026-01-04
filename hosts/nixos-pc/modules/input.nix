{ pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [pkgs.qt6Packages.fcitx5-unikey];
        waylandFrontend = true;
      };
    };
  };
}
