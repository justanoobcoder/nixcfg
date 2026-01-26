{pkgs ? import <nixpkgs> {}}: {
  keypop = pkgs.callPackage ./keypop {};
  wlctl = pkgs.callPackage ./wlctl {};
  fcitx5-vmk = pkgs.callPackage ./fcitx5-vmk {};
}
