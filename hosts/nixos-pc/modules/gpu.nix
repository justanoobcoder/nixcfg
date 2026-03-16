{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
}
