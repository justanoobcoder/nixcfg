{
  perSystem =
    { pkgs, lib, ... }:
    {
      # clice, the C/C++ language server, from its release binaries: nixpkgs has none.
      packages.clice = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "clice";
        version = "1.0.0";

        src =
          let
            sources = {
              # TODO(clice-io/clice#1100): back to the upstream release once one carries the fix.
              # 1.0.0 plus the fix for GCC's split -D/-U, which breaks every file under Nix's
              # gcc wrapper ("macro name must be an identifier"), from a pre-release of the fork.
              x86_64-linux = {
                url = "https://github.com/justanoobcoder/clice/releases/download/v1.0.0-gcc-split-macros/clice-1.0.0-gde60f264.x86_64-unknown-linux-gnu.tar.gz";
                hash = "sha256-xNnD13nbLzavaHz67AsjY2xOx+RP7B9dGF3Mu4W2qww=";
              };
              aarch64-linux = {
                url = "https://github.com/clice-io/clice/releases/download/v${finalAttrs.version}/clice-${finalAttrs.version}.aarch64-unknown-linux-gnu.tar.gz";
                hash = "sha256-t+ts5lr7nNxSKdrfGxpWFIXc2ykqBtaIV81gl3FvCLo=";
              };
            };
            inherit (pkgs.stdenv.hostPlatform) system;
          in
          pkgs.fetchurl (sources.${system} or (throw "clice: no release for ${system}"));

        nativeBuildInputs = [ pkgs.autoPatchelfHook ];

        # clice finds its clang resource headers at ../lib/clang beside its binary.
        installPhase = ''
          runHook preInstall
          mkdir -p $out
          cp -r bin lib $out/
          runHook postInstall
        '';

        meta = {
          description = "Language server for modern C++";
          homepage = "https://github.com/clice-io/clice";
          license = lib.licenses.asl20;
          platforms = [
            "x86_64-linux"
            "aarch64-linux"
          ];
          mainProgram = "clice";
          sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
        };
      });
    };
}
