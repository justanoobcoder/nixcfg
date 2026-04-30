{
  flake.homeModules.hmXdg = {config, ...}: {
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

      mimeApps = {
        enable = true;
        defaultApplications = let
          browsers = ["zen.desktop"];
          videoPlayers = [
            "mpv.desktop"
            "umpv.desktop"
          ];
          imageViewers = ["imv.desktop"];
          textEditors = ["neovide.desktop"];
        in {
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
          #"text/csv" = ["wps-office-et.desktop"];
          #"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["wps-office-et.desktop"];
          #"application/vnd.ms-excel" = ["wps-office-et.desktop"];
          #"application/msword" = ["wps-office-wps.desktop"];
          #"application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
          #  "wps-office-wps.desktop"
          #];
          #"application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
          #  "wps-office-wpp.desktop"
          #];
          #"application/vnd.ms-powerpoint" = ["wps-office-wpp.desktop"];
          #"application/pdf" = ["wps-office-pdf.desktop"];
          "image/svg+xml" = browsers;
          "text/html" = browsers;
        };
      };
    };
  };
}
