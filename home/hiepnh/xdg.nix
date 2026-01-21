{pkgs, inputs, ...}: {
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    mpv
    imv
    neovide
  ];

  xdg = {
    autostart.enable = true; # Enable creation of XDG autostart entries.
    configFile = {
      "mimeapps.list".force = true;
    };
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      broswers = ["zen.desktop"];
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
      "image/svg+xml" = broswers;
      "text/html" = broswers;
    };
  };
}
