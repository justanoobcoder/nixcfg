{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./lsp
    ./keymaps.nix
    ./indent.nix
    ./comment.nix
    ./filetree.nix
    ./theme.nix
    ./dashboard.nix
    ./terminal.nix
    ./persist.nix
    ./colorizer.nix
    ./autocomplete.nix
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        globals.mapleader = " ";
        hideSearchHighlight = true;
        syntaxHighlighting = true;
        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        options = {
          mouse = "a";
          tabstop = 2;
          shiftwidth = 2;
          smartindent = true;
        };
        git.gitsigns.enable = true;
        autopairs.nvim-autopairs.enable = true;
        tabline.nvimBufferline.enable = true;
        tabline.nvimBufferline.setupOpts.options.numbers = "none";
        statusline.lualine.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        additionalRuntimePaths = [
          "$HOME/.nixcfg/home/hiepnh/programs/nvf/runtime"
        ];
      };
    };
  };
}
