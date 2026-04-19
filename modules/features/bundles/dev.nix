{self, ...}: {
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
        self.homeModules.git
        self.homeModules.tmux
      ];
    };
  };
}
