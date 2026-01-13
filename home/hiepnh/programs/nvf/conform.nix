{pkgs, ...}: {
  programs.nvf.settings.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters = {
          clang_format = {
            command = "clang-format";
            args = [
              "--style={IndentWidth: 4, TabWidth: 4}"
            ];
          };
        };
        formatters_by_ft = {
          c = ["clang_format"];
          nix = ["alejandra"];
          lua = ["stylua"];
          bash = ["shfmt"];
          rust = ["rustfmt"];
        };
      };
    };
    extraPackages = with pkgs; [
      alejandra # nix
      clang-tools #c/c++
      stylua # lua
      shfmt # bash
      rustfmt
    ];
  };
}
