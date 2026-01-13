{
  programs.nvf.settings.vim = {
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        sources = ["filesystem" "buffers" "git_status"];
        open_files_do_not_replace_types = ["terminal" "Trouble" "trouble" "qf" "Outline"];
        filesystem = {
          bind_to_cwd = false;
          follow_current_file = {
            enabled = true;
          };
          use_libuv_file_watcher = true;
        };
        close_if_last_window = true;
      };
    };
  };
}
