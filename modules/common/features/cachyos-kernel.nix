{ inputs, ... }:
{
  flake.nixosModules.cachyosKernel =
    {
      pkgs,
      lib,
      ...
    }:
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];

      boot.kernelPackages = pkgs.linuxPackagesFor (
        pkgs.cachyosKernels.linux-cachyos-bore-lto-x86_64-v3.override {
          structuredExtraConfig = builtins.mapAttrs (_: lib.mkForce) (
            with lib.kernel;
            {
              # Module Compression (Switch from XZ to ZSTD)
              MODULE_COMPRESS_XZ = no;
              MODULE_COMPRESS_ZSTD = yes;
            }
          );

          ignoreConfigErrors = true;
        }
      );
    };
}
