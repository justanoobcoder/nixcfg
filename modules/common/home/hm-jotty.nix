{ inputs, ... }: {
  flake.homeModules.hmJotty = _: {
    imports = [ inputs.jotty.homeManagerModules.default ];

    programs.jotty = {
      enable = true;
      settings = {
        colors = {
          background = "#282828";
          cursor = "#ebdbb2";
          cursor_text = "#282828";
          foreground = "#ebdbb2";
          palette = [
            "#282828"
            "#cc241d"
            "#98971a"
            "#d79921"
            "#458588"
            "#b16286"
            "#689d6a"
            "#a89984"
            "#928374"
            "#fb4934"
            "#b8bb26"
            "#fabd2f"
            "#83a598"
            "#d3869b"
            "#8ec07c"
            "#ebdbb2"
          ];
          selection_background = "#665c54";
          selection_foreground = "#ebdbb2";
        };
        font = {
          family = "JetBrains Mono Nerd Font";
          size = 12.4;
        };
        keybinds = {
          copy_last_output = [ "ctrl+shift+o" ];
          copy_or_interrupt = [ "ctrl+c" ];
          vi_mode = [ "shift+escape" ];
        };
        terminal = {
          output_click = "copy";
          scrollback = 5000;
        };
        window = {
          opacity = 0.8;
        };
      };
    };
  };
}
