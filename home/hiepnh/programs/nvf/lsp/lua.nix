{
  programs.nvf.settings.vim = {
    languages = {
      lua = {
        enable = true;
        lsp.enable = true;
        lsp.servers = ["lua-language-server"];
        treesitter.enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        format.type = ["stylua"];
      };
    };
  };
}
