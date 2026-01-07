{
  programs.nvf.settings.vim = {
    dashboard.dashboard-nvim = {
      enable = true;
    };
    luaConfigRC.dashboard = builtins.readFile ./lua/dashboard.lua;
  };
}
