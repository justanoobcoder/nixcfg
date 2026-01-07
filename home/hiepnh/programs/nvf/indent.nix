{
  programs.nvf.settings.vim = {
    visuals.indent-blankline = {
      enable = true;
      setupOpts.scope.enabled = false;
      setupOpts.indent.char = "▏";
    };
    mini.indentscope = {
      enable = true;
      setupOpts = {
        symbol = "▏";
      };
    };
    luaConfigPost = ''
          vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
            link = "SpecialChar"
          })
    '';
  };
}
