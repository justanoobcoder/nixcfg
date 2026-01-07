{
  programs.nvf.settings.vim = {
    visuals.indent-blankline = {
      enable = true;
      setupOpts.scope.enabled = false;
      setupOpts.indent.char = "▏";
      setupOpts.exclude.filetypes = ["dashboard"];
    };
    mini.indentscope = {
      enable = true;
      setupOpts = {
        symbol = "▏";
        ignore_filetypes = ["dashboard"];
      };
    };
    luaConfigPost = ''
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
        link = "SpecialChar"
      })
    '';
  };
}
