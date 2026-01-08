{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins.persisted-nvim = {
      package = pkgs.vimPlugins.persisted-nvim;
    };
  };
}
