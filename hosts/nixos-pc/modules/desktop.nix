{
  inputs,
  pkgs,
  ...
}: {
  services.libinput.enable = true;

  hardware.bluetooth.enable = true;

  programs = {
    niri = {
      enable = true;
      package = let
        newSrc = pkgs.fetchFromGitHub {
          owner = "YaLTeR";
          repo = "niri";
          rev = "main";
          hash = "sha256-D5ME/gcvzCqr2pqd8iw3Nx7v31CBdQLt5iFfF0PZKDw=";
        };
      in
        pkgs.niri.overrideAttrs (old: {
          src = newSrc;
          cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
            src = newSrc;
            hash = "sha256-XbKhPJ/VxcLf4J2I6dekKnUvCnmoXndvQsLx2B04ihE=";
          };
          postPatch = ''
            patchShebangs resources/niri-session
          '';
        });
    };

    # hyprland = {
    #   enable = true;
    #   withUWSM = true;
    #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # };

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
