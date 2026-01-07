{
  programs.nvf.settings.vim = {
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        close_if_last_window = true;
        window = {
          width = 35;
          mappings = {
            "<cr>" = "open_tabnew";
          };
        };
      };
    };
  };
}
