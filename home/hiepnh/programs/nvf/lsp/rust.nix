{
  programs.nvf.settings.vim = {
    languages = {
      rust = {
        enable = true;
        lsp.enable = true;
        treesitter.enable = true;
        extensions.crates-nvim = {
          enable = true;
          setupOpts.completion.crates.enable = true;
        };
      };
    };
  };
}
