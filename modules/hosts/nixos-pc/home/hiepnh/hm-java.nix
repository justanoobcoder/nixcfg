{
  flake.homeModules.hmJava = { pkgs, ... }: {
    programs.java.enable = true;

    home.packages = with pkgs; [
      maven
    ];
  };
}
