{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins.persisted-nvim = {
      package = pkgs.vimPlugins.persisted-nvim;
    };
    luaConfigRC.persisted = builtins.readFile ./lua/persisted.lua;
  };
}
