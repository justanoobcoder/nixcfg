{ self, ... }:
{
  flake.nixosModules.bundleDev = _: {
    imports = [
      self.nixosModules.gnupg
      self.nixosModules.openssh
      self.nixosModules.distroboxPodman
    ];
  };

  flake.homeModules.bundleDev = _: {
    imports = [
      self.homeModules.hmGit
    ];
  };
}
