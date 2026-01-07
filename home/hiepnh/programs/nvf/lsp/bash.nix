{
  programs.nvf.settings.vim = {
    languages = {
      bash = {
        enable = true;
        lsp.enable = true;
        lsp.servers = ["bash-ls"];
        treesitter.enable = true;
        extraDiagnostics.enable = true;
        format.enable = true;
        format.type = ["shfmt"];
      };
    };
  };
}
