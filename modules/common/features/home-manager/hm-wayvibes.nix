{ inputs, ... }:
{
  flake.homeModules.hmWayvibes = _: {
    imports = [
      inputs.wayvibes.nixosModules.default
    ];

    services.wayvibes = {
      enable = true;
      soundpack = "/home/hiepnh/Projects/wayvibes/soundpacks/cherrymx-red-abs";
      volume = 3;
    };
  };
}
