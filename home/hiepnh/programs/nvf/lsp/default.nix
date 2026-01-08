{lib, ...}: {
  imports = [
    ./nix.nix
    ./bash.nix
    ./lua.nix
    ./clang.nix
  ];

  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      lspconfig.enable = true;
      inlayHints.enable = true;
      formatOnSave = false;
      servers.amber = {
        enable = false;
        cmd = ["amber-lsp"];
        filetypes = ["amber"];
      };
    };
    diagnostics = {
      enable = true;
      config = {
        signs.text = lib.generators.mkLuaInline ''
                      {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "",
                      }
        '';
        virtual_text = true;
        update_in_insert = true;
      };
    };
  };
}
