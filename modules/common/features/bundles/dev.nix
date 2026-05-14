{ self, ... }:
{
  flake.devBundle = {
    nixosModules = _: {
      imports = [
        self.nixosModules.gnupg
        self.nixosModules.openssh
        self.nixosModules.docker
      ];
    };

    homeModules = _: {
      imports = [
        self.homeModules.hmGit
        self.homeModules.hmTmux
      ];
    };
  };
}
