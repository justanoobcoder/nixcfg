{self, ...}: {
  flake.homeModules.hiepnhModule = _: {
    imports = [
      self.coreSystemBundle.homeModules
      self.devBundle.homeModules
      self.niriDesktopBundle.homeModules

      self.homeModules.xdg
      self.homeModules.syncthing
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
