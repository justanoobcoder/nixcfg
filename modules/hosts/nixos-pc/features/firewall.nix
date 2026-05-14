{
  flake.nixosModules.firewall = _: {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        3000
        8080
        8888
        53317
      ];
      allowedUDPPorts = [ 53317 ];
    };
  };
}
