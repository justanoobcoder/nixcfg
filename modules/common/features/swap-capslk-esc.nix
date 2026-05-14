{
  flake.nixosModules.swapCapslkEsc = _: {
    services = {
      keyd = {
        enable = true;
        keyboards = {
          default = {
            ids = [ "*" ];
            settings = {
              main = {
                capslock = "overload(control, esc)";
                esc = "capslock";
              };
            };
          };
        };
      };
    };
    systemd.services.keyd.serviceConfig = {
      SuccessExitStatus = [
        0
        15
      ];
    };
  };
}
