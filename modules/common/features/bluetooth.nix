{
  flake.nixosModules.bluetooth = _: {
    hardware.bluetooth.enable = true;
  };
}
