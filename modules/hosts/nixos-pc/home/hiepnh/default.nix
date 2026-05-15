{ self, ... }:
{
  flake.homeModules.hiepnhModule = _: {
    imports = [
      self.coreSystemBundle.homeModules
      self.devBundle.homeModules
      self.niriDesktopBundle.homeModules

      self.homeModules.hmFish
      self.homeModules.hmEnv
      self.homeModules.hmXdg
      self.homeModules.hmSyncthing
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
      signingKey = "88ADF3E7C761E5A7";
    };
  };
}
