{
  flake.nixosModules.nvidia =
    { pkgs, ... }:
    {
      hardware = {
        graphics = {
          enable = true;
          extraPackages = with pkgs; [
            intel-media-driver
            nvidia-vaapi-driver
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

      services.xserver.videoDrivers = [ "nvidia" ];

      environment.variables = {
        LIBVA_DRIVER_NAME = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
        NVD_BACKEND = "direct";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __GL_GSYNC_ALLOWED = "1";
      };
    };
}
