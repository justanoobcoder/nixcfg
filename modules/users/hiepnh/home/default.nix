{ self, ... }:
{
  flake.homeModules.userHiepnh = { config, ... }: {
    imports = [
      self.homeModules.bundleDev
      self.homeModules.bundleDesktop

      self.homeModules.userHiepnhFish
      self.homeModules.userHiepnhEnv
      self.homeModules.userHiepnhXdg
      self.homeModules.userHiepnhTheme
      self.homeModules.hmSyncthing
      self.homeModules.hmKeywave
      self.homeModules.userHiepnhJava
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
