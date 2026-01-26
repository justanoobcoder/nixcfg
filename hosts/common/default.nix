{lib, ...}: {
  imports =
    builtins.filter
    (path: lib.hasSuffix ".nix" path && !(lib.hasPrefix "default.nix" (baseNameOf path)))
    (map (f: ./. + "/${f}") (builtins.attrNames (builtins.readDir ./.)));

  nix.settings.download-buffer-size = 524288000;
}
