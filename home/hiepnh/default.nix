{lib, ...}: {
  imports =
    [
      ../common
      ./programs
    ]
    ++ (
      builtins.filter
      (path: lib.hasSuffix ".nix" path && (baseNameOf path) != "default.nix")
      (map (f: ./. + "/${f}") (builtins.attrNames (builtins.readDir ./.)))
    );

  home = {
    username = "hiepnh";
    homeDirectory = "/home/hiepnh";
    stateVersion = "26.05";
  };
}
