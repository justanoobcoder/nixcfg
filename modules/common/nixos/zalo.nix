{ inputs, ... }: {
  flake.nixosModules.zalo =
    { pkgs, ... }:
    {
      imports = [ inputs.zalo-for-linux.nixosModules.default ];

      programs.zalo = {
        enable = true;
        # The flake's package uses its own nixpkgs instance, which our overlays don't reach.
        # Take dwarfs from our pkgs so the dwarfs overlay applies.
        package = inputs.zalo-for-linux.packages.${pkgs.stdenv.hostPlatform.system}.zalo.override {
          inherit (pkgs) dwarfs;
        };
      };
    };
}
