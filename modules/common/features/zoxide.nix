{
  flake.nixosModules.zoxide = _: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
