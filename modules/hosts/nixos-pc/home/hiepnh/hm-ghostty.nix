{
  flake.homeModules.hmGhostty = _: {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      settings = {
        font-family = "JetBrains Mono Nerd Font";
        font-family-bold = "JetBrainsMono NF Bold";
        font-family-italic = "JetBrainsMono NF Italic";
        font-family-bold-italic = "JetBrainsMono NF Bold Italic";
        font-size = 12;
        font-feature = "calt,liga,dlig";
        theme = "Gruvbox Dark";
        background-opacity = "0.8";
        background-blur = true;

        keybind = [
          "performable:ctrl+c=copy_to_clipboard"
        ];
      };
    };
  };
}
