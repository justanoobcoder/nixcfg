{ self, ... }: {
  flake.homeModules.hmKeywave = { pkgs, ... }: {
    systemd.user.services.keywave =
      let
        keywavePkg = self.packages.${pkgs.stdenv.hostPlatform.system}.keywave;
      in
      {
        Unit = {
          Description = "KeyWave keyboard sound";
          After = [
            "pipewire.service"
            "graphical-session.target"
          ];
          Wants = [ "pipewire.service" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = "${keywavePkg}/bin/keywave";
          Restart = "on-failure";
          RestartSec = 3;
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
  };
}
