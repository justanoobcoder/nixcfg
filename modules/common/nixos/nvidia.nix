{
  flake.nixosModules.nvidia =
    { pkgs, ... }:
    {
      hardware = {
        graphics = {
          enable = true;
          extraPackages = with pkgs; [ nvidia-vaapi-driver ];
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
        # EGL from NVIDIA only: Mesa's EGL has no driver for the card ("failed to
        # create dri2 screen") and froze Zalo when it started a screen share
        __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
        __GL_GSYNC_ALLOWED = "1";
      };
    };
}
