{
  flake.nixosModules.nvidia = {pkgs, ...}: {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
        ];
      };
      nvidia = {
        open = false;
        powerManagement = {
          enable = true;
          finegrained = false;
        };
        modesetting.enable = true;
      };
    };
    services.xserver.videoDrivers = ["nvidia"];
  };
}
