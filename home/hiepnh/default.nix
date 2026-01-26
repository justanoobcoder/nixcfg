{lib, ...}: {
  imports =
    [
      ../common
      ./programs
    ]
    ++ (
      builtins.filter
      (path: lib.hasSuffix ".nix" path && !(lib.hasPrefix "default.nix" (baseNameOf path)))
      (map (f: ./. + "/${f}") (builtins.attrNames (builtins.readDir ./.)))
    );

  home = {
    username = "hiepnh";
    homeDirectory = "/home/hiepnh";
    stateVersion = "25.11";
  };
}
