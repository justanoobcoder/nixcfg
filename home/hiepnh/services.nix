{pkgs, ...}: {
  services.syncthing.enable = true;
  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
      };
    };
  };
}
