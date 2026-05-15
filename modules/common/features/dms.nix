{
  flake.nixosModules.dms =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      programs.dms-shell = {
        enable = true;
        package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
        quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      };
    };
}
