{ pkgs, ... }:
{
  keypop = pkgs.callPackage ./keypop {};
  wlctl = pkgs.callPackage ./wlctl {};
  #zalo = pkgs.callPackage ./zalo {};
}
