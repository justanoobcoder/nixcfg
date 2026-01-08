{
  programs.nvf.settings.vim.ui.colorizer = {
    enable = true;
    setupOpts = {
      user_default_options.names = false;
      filetypes = {
        "*" = {};
        css = {
          names = true;
        };
      };
    };
  };
}
