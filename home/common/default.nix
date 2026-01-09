{config, ...}: {
  xdg.enable = true;

  xdg.userDirs = {
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
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      XDG_SCREENCAST_DIR = "${config.xdg.userDirs.videos}/recordings";
    };
  };
}
