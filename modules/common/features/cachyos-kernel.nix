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
      boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      nix.settings.substituters = [ "https://cache.garnix.io" ];
      nix.settings.trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
}
