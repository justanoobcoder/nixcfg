{pkgs, ...}: let
  fcitx5-vmk = pkgs.callPackage ../../../pkgs/fcitx5-vmk/default.nix {};
in {
  environment.systemPackages = [fcitx5-vmk];

  users.users.uinput_proxy = {
    isSystemUser = true;
    group = "input";
    description = "User for Fcitx5 VMK Server";
  };

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

  systemd.packages = [fcitx5-vmk];
  services.udev.packages = [fcitx5-vmk];

  systemd.targets.multi-user.wants = ["fcitx5-vmk-server@hiepnh.service"];
}
