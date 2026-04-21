{inputs, ...}: {
  flake.homeModules.wayvibes = _: {
    imports = [
      inputs.wayvibes.nixosModules.default
    ];

    services.wayvibes = {
      enable = true;
      soundpack = "/home/hiepnh/proj/wayvibes/soundpacks/cherrymx-red-abs";
      volume = 3;
    };
  };
}
