{self, ...}: {
  flake.homeModules.hiepnhModule = _: {
    imports = [
      self.niriDesktopBundle.homeModules

      self.homeModules.git
      self.homeModules.xdg
      self.homeModules.syncthing
      self.homeModules.tmux
    ];

    home = {
      username = "hiepnh";
      homeDirectory = "/home/hiepnh";
      stateVersion = "26.05";
    };

    hm.git = {
      userName = "Nguyen Hong Hiep";
      userEmail = "syaorancode@gmail.com";
      defaultBranch = "main";
    };
  };
}
