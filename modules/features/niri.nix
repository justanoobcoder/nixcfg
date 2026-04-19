{
  flake.nixosModules.niri = {pkgs, ...}: {
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
          pkgs.niri.overrideAttrs (_: {
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
      xwayland = {
        enable = true;
        package = pkgs.xwayland-satellite;
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
    };
  };
}
