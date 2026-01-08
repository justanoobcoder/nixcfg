{
  programs.nvf.settings.vim.autocomplete.nvim-cmp = {
    enable = true;
    sourcePlugins = [
      "cmp-path"
    ];
    sources = {
      nvim_lsp = "[LSP]";
      buffer = "[Buffer]";
      path = "[Path]";
    };
  };
}
