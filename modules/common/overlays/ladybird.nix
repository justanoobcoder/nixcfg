{
  flake.overlays.ladybird = _: prev: rec {
    zmij =
      prev.zmij or (prev.stdenv.mkDerivation rec {
        pname = "zmij";
        version = "1.2";
        src = prev.fetchFromGitHub {
          owner = "vitaut";
          repo = "zmij";
          rev = "v${version}";
          hash = "sha256-2tppKuONy9IS5IzGJF+4bqAav3aaQMZjiQCMoi5WscE=";
        };
        nativeBuildInputs = [ prev.cmake ];
        cmakeFlags = [
          "-DBUILD_SHARED_LIBS=ON"
          "-DZMIJ_TEST=OFF"
          "-DZMIJ_EXAMPLE=OFF"
        ];
      });

    ladybird = prev.ladybird.overrideAttrs (old: rec {
      pname = "ladybird";
      version = "0-unstable-2026-10-22";
      src = prev.fetchFromGitHub {
        owner = "LadybirdBrowser";
        repo = "ladybird";
        rev = "b60be2e29b721f4748998e598cda2361d05462f6";
        hash = "sha256-G6GtSYqspok3N6Ic/8edh3RUQnK3vZD2D7XULTk7EKs=";
      };

      cargoDeps = prev.rustPlatform.fetchCargoVendor {
        inherit pname version src;
        hash = "sha256-vvWIImNXEbN+S1VFX/qqgP+hT5QSBbUfPseDeXc7yNg=";
      };

      buildInputs = (old.buildInputs or [ ]) ++ [ zmij ];

      postPatch =
        let
          pdfjsMatch = builtins.match "(.*)(cp -r /nix/store/[^ ]+-pdfjs-[^/]+/share/pdf\\.js pdfjs)(.*)" (
            old.postPatch or ""
          );
          replacedPdfjs =
            if pdfjsMatch != null then
              builtins.replaceStrings
                [ (builtins.elemAt pdfjsMatch 1) ]
                [ "cp -r ${prev.pdfjs}/share/pdf.js pdfjs" ]
                (old.postPatch or "")
            else
              (old.postPatch or "");
          patchedOldPostPatch =
            builtins.replaceStrings
              [ "--replace-fail libavformat-ladybird libavformat" ]
              [ "--replace-quiet libavformat-ladybird libavformat" ]
              replacedPdfjs;
        in
        patchedOldPostPatch
        + ''
          substituteInPlace Meta/CMake/compile_options.cmake \
            --replace-fail 'add_cxx_compile_options(-march=native)' 'add_cxx_compile_options(-march=alderlake -mtune=alderlake)' \
            --replace-fail 'set(RUSTC_TARGET_CPU_FLAGS -Ctarget-cpu=native)' 'set(RUSTC_TARGET_CPU_FLAGS -Ctarget-cpu=alderlake)'

          substituteInPlace Meta/CMake/rust_crate.cmake \
            --replace-fail 'set(RUSTC_TARGET_FLAGS -Dwarnings' 'set(RUSTC_TARGET_FLAGS'
        '';
    });
  };
}
