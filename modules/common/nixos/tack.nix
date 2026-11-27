{ inputs, ... }:
{
  flake.nixosModules.tack =
    { pkgs, ... }:
    {
      # nixpkgs ships tack 1.0.1, which can't read the 2.0 lock and resolver in .tack.
      programs.tack = {
        enable = true;
        package = inputs.tack.packages.${pkgs.stdenv.hostPlatform.system}.tack;
      };
    };
}
