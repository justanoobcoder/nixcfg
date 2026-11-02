{
  flake.nixosModules.intelGraphics =
    { pkgs, ... }:
    {
      hardware.graphics = {
        enable = true;
        # VA-API driver for Intel iGPUs (Broadwell and newer)
        extraPackages = with pkgs; [ intel-media-driver ];
      };
    };
}
