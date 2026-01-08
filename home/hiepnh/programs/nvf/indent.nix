let
  ignore_filetypes = ["dashboard" "startify" "ministarter"];
in {
  programs.nvf.settings.vim = {
    visuals.indent-blankline = {
      enable = true;
      setupOpts = {
        scope.enabled = false;
        indent.char = "▏";
        exclude.filetypes = ignore_filetypes;
      };
    };
    mini.indentscope = {
      enable = true;
      setupOpts = {
        symbol = "▏";
        inherit ignore_filetypes;
      };
    };
    luaConfigPost = ''
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
        link = "SpecialChar"
      })
    '';
  };
}
