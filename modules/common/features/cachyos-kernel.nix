{ inputs, ... }:
{
  flake.nixosModules.cachyosKernel =
    {
      pkgs,
      ...
    }:
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
      nix.settings.substituters = [ "https://cache.xinux.uz" ];
      nix.settings.trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
      ];
      # nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
      # nix.settings.trusted-public-keys = [
      #   "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      # ];
    };
}
