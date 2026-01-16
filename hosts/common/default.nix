{
  imports = [
    ./bootloader.nix
    ./services.nix
    ./gpg.nix
    ./optimise-disk.nix
  ];

  nix.settings.download-buffer-size = 524288000;
}
