{
  # Upstream builds Rust code with `-Ctarget-cpu=native` unless ENABLE_CI_BASELINE_CPU is set.
  # Nix's cc-wrapper strips -march=native for C++, but not for rustc, so the Hydra binary
  # contains AVX-512 instructions and dies with SIGILL on CPUs without AVX-512.
  flake.overlays.ladybird = _: prev: {
    ladybird = prev.ladybird.overrideAttrs (old: {
      cmakeFlags = (old.cmakeFlags or [ ]) ++ [
        (prev.lib.cmakeBool "ENABLE_CI_BASELINE_CPU" true)
      ];
    });
  };
}
