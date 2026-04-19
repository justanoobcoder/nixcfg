{
  flake.overlays.niri = _: prev: {
    niri = let
      newSrc = prev.fetchFromGitHub {
        owner = "YaLTeR";
        repo = "niri";
        rev = "main";
        hash = "sha256-D5ME/gcvzCqr2pqd8iw3Nx7v31CBdQLt5iFfF0PZKDw=";
      };
    in
      prev.niri.overrideAttrs (_: {
        src = newSrc;
        cargoDeps = prev.rustPlatform.fetchCargoVendor {
          src = newSrc;
          hash = "sha256-XbKhPJ/VxcLf4J2I6dekKnUvCnmoXndvQsLx2B04ihE=";
        };
        postPatch = ''
          patchShebangs resources/niri-session
        '';
      });
  };
}
