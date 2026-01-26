{pkgs ? import <nixpkgs> {}}: {
  keypop = pkgs.callPackage ./keypop {};
  wlctl = pkgs.callPackage ./wlctl {};
}
