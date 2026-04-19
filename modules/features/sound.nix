{
  flake.nixosModules.sound = _: {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
