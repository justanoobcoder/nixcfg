{
  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        useBabelfish = true;
      };

      environment.systemPackages = with pkgs; [
        babelfish
      ];
    };
}
