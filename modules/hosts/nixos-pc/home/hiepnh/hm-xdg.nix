{
  flake.homeModules.hmXdg =
    { config, ... }:
    {
      xdg = {
        enable = true;
        autostart.enable = true; # Enable creation of XDG autostart entries.

        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = "${config.home.homeDirectory}/xdg/desktop";
          documents = "${config.home.homeDirectory}/xdg/documents";
          download = "${config.home.homeDirectory}/xdg/downloads";
          videos = "${config.home.homeDirectory}/xdg/videos";
          music = "${config.home.homeDirectory}/xdg/music";
          pictures = "${config.home.homeDirectory}/xdg/pictures";
          publicShare = "${config.home.homeDirectory}/xdg/public";
          templates = "${config.home.homeDirectory}/xdg/templates";
          extraConfig = {
            SCREENSHOTS = "${config.xdg.userDirs.pictures}/screenshots";
            SCREENCAST = "${config.xdg.userDirs.videos}/recordings";
          };
        };

        configFile = {
          "mimeapps.list".force = true;
        };

        # xdg-open ignores Terminal=true outside a known desktop, so terminal
        # programs get entries that open them in a jotty window.
        desktopEntries = {
          nvim-jotty = {
            name = "Neovim (jotty)";
            exec = "jotty -e nvim %F";
            terminal = false;
            noDisplay = true;
          };
          yazi-jotty = {
            name = "Yazi (jotty)";
            exec = "jotty -e yazi %f";
            terminal = false;
            noDisplay = true;
          };
        };

        mimeApps = {
          enable = true;
          defaultApplications =
            let
              browsers = [ "helium.desktop" ];
              videoPlayers = [
                "mpv.desktop"
                "umpv.desktop"
              ];
              imageViewers = [ "imv.desktop" ];
              textEditors = [ "nvim-jotty.desktop" ];
              fileManagers = [ "yazi-jotty.desktop" ];
              documents = [ "ai.storyteller.wordcraft.desktop" ];
              spreadsheets = [ "ai.storyteller.gridcraft.desktop" ];
              presentations = [ "ai.storyteller.deckcraft.desktop" ];
              pdfViewers = [ "ai.storyteller.pdfcraft.desktop" ];
            in
            {
              "audio/mp3" = videoPlayers;
              "audio/aac" = videoPlayers;
              "audio/wav" = videoPlayers;
              "video/mp4" = videoPlayers;
              "video/mpeg" = videoPlayers;
              "image/png" = imageViewers;
              "image/jpeg" = imageViewers;
              "image/gif" = imageViewers;
              "image/webp" = imageViewers;
              "text/plain" = textEditors;
              "application/json" = textEditors;
              "application/toml" = textEditors;
              "application/yaml" = textEditors;
              "application/x-yaml" = textEditors;
              "application/x-shellscript" = textEditors;
              "text/markdown" = textEditors;
              "text/rust" = textEditors;
              "text/x-nix" = textEditors;
              "text/x-shellscript" = textEditors;
              "text/x-python" = textEditors;
              "text/x-lua" = textEditors;
              "text/x-go" = textEditors;
              "text/x-csrc" = textEditors;
              "text/x-chdr" = textEditors;
              "text/x-c++src" = textEditors;
              "text/x-c++hdr" = textEditors;
              "text/javascript" = textEditors;
              "text/x-patch" = textEditors;
              "text/x-log" = textEditors;
              "inode/directory" = fileManagers;
              "application/msword" = documents;
              "application/msword-template" = documents;
              "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = documents;
              "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = documents;
              "application/vnd.ms-word.document.macroEnabled.12" = documents;
              "application/vnd.ms-word.template.macroEnabled.12" = documents;
              "application/vnd.oasis.opendocument.text" = documents;
              "application/rtf" = documents;
              "text/rtf" = documents;
              "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = spreadsheets;
              "application/vnd.ms-excel.sheet.macroEnabled.12" = spreadsheets;
              "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = spreadsheets;
              "application/vnd.oasis.opendocument.spreadsheet" = spreadsheets;
              "text/csv" = spreadsheets;
              "text/tab-separated-values" = spreadsheets;
              "application/vnd.openxmlformats-officedocument.presentationml.presentation" = presentations;
              "application/vnd.openxmlformats-officedocument.presentationml.template" = presentations;
              "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = presentations;
              "application/x-deckcraft" = presentations;
              "application/pdf" = pdfViewers;
              "image/svg+xml" = browsers;
              "text/html" = browsers;
              "x-scheme-handler/http" = browsers;
              "x-scheme-handler/https" = browsers;
            };
        };
      };
    };
}
