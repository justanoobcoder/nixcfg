{
  # libarchive 3.8.10 makes archive_write_close() fail after a failed write, so dwarfsextract
  # throws before joining its I/O thread and calls std::terminate(): the pwb, raw and xar
  # dwarfsextract_format_test cases abort and dwarfs 0.15.8 fails to build.
  # Fix from the open PR https://github.com/mhx/dwarfs/pull/391, packaged in
  # https://github.com/NixOS/nixpkgs/pull/586760. Drop once nixpkgs includes it.
  flake.overlays.dwarfs = _: prev: {
    dwarfs = prev.dwarfs.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (prev.fetchpatch {
          name = "dwarfs-always-join-io-thread.patch";
          url = "https://github.com/mhx/dwarfs/commit/0f5a7720f03dbb2e2fb12300272826fb458aac5f.patch?full_index=1";
          hash = "sha256-laGlfPZgfG5Xn8Se/7XTK3wYg0hhsOMQhzWTlwBZQR8=";
        })
      ];
    });
  };
}
