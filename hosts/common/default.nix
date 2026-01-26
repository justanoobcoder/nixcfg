{lib, ...}: {
  imports =
    builtins.filter
    (path: lib.hasSuffix ".nix" path && !(lib.hasPrefix "default.nix" (baseNameOf path)))
    (map (f: ./. + "/${f}") (builtins.attrNames (builtins.readDir ./.)));

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.download-buffer-size = 524288000;
}
