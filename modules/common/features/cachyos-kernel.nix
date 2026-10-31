{ inputs, ... }:
{
  flake.nixosModules.cachyosKernel =
    {
      pkgs,
      lib,
      ...
    }:
    {
      nix.settings.substituters = [ "https://cache.lantian.pub/lantian" ];
      nix.settings.trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];

      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;

      # boot.kernelPackages = pkgs.linuxPackagesFor (
      #   pkgs.cachyosKernels.linux-cachyos-bore-lto-x86_64-v3.override {
      #     structuredExtraConfig = builtins.mapAttrs (_: lib.mkForce) (
      #       with lib.kernel;
      #       {
      #         # Module Compression (Switch from XZ to ZSTD)
      #         MODULE_COMPRESS_XZ = no;
      #         MODULE_COMPRESS_ZSTD = yes;
      #       }
      #     );
      #
      #     ignoreConfigErrors = true;
      #   }
      # );
    };
}
