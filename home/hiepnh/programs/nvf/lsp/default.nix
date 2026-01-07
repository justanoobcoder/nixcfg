{lib, ...}: {
  imports = [
    ./nix.nix
    ./bash.nix
  ];

  programs.nvf.settings.vim = {
    lsp = {
      enable = true;
      inlayHints.enable = true;
      formatOnSave = true;
      servers.amber = {
        enable = true;
        cmd = ["amber-lsp"];
        filetypes = ["amber"];
      };
    };
    autocomplete.nvim-cmp.enable = true;
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
