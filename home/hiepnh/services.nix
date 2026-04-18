{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.wayvibes.nixosModules.default
  ];

  services = {
    syncthing.enable = true;

    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
        };
      };
    };

    wayvibes = {
      enable = true;
      soundpack = "/home/hiepnh/proj/wayvibes/soundpacks/cherrymx-red-abs";
      volume = 5;
    };
  };
}
