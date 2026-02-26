{
  inputs,
  pkgs,
  ...
}: {
  services.libinput.enable = true;

  hardware.bluetooth.enable = true;

  programs = {
    niri.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        niri-session = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };
    xwayland = {
      enable = true;
      package = pkgs.xwayland-satellite;
    };
    dms-shell = {
      enable = true;
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
