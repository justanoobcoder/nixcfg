{ self, ... }:
{
  flake.homeModules.hiepnhModule = { config, ... }: {
    imports = [
      self.coreSystemBundle.homeModules
      self.devBundle.homeModules
      self.desktopBundle.homeModules

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
      signingFormat = "ssh";
      signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };
  };
}
