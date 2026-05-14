{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs = {
        niri = {
          enable = true;
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

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
