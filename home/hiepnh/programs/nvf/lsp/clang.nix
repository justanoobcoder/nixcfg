{
  programs.nvf.settings.vim = {
    languages = {
      clang = {
        enable = true;
        cHeader = true;
        lsp.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
