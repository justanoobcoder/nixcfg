{
  flake.overlays.niri = _: prev: {
    niri = let
      newSrc = prev.fetchFromGitHub {
        owner = "YaLTeR";
        repo = "niri";
        rev = "68bb942d2146cd2c8af69c0f16db18396b4388fe";
        hash = "sha256-7Bbp0fDBJMDRpKfdHelMXbhY51bdCa5+Qn/+XONaOwk=";
      };
    in
      prev.niri.overrideAttrs (_: {
        src = newSrc;
        cargoDeps = prev.rustPlatform.fetchCargoVendor {
          src = newSrc;
          hash = "sha256-tievZgYwlZ/zUjl/R6B3UFmFiav9tHxAujxPQjP6niU=";
        };
        postPatch = ''
          patchShebangs resources/niri-session
        '';
      });
  };
}
