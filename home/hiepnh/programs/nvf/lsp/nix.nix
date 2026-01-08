{
  programs.nvf.settings.vim = {
    languages = {
      nix = {
        enable = true;
        lsp.enable = true;
        lsp.servers = ["nixd"];
        treesitter.enable = true;
        extraDiagnostics.enable = true;
      };
    };
  };
}
