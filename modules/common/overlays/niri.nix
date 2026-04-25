{
  flake.overlays.niri = _: prev: {
    niri = let
      newSrc = prev.fetchFromGitHub {
        owner = "YaLTeR";
        repo = "niri";
        rev = "4438aefc8d01b775ee855f96c7d93b16e55a7a9f";
        hash = "sha256-W4KXT0RtNYs+qe2ScroVRiaaenlfJpI8aU/DLk2t8/0=";
      };
    in
      prev.niri.overrideAttrs (_: {
        src = newSrc;
        cargoDeps = prev.rustPlatform.fetchCargoVendor {
          src = newSrc;
          hash = "sha256-gfnalA3qI3a9h3PvsxgQLCrzapfjLLkxhTMJpwRh+ro=";
        };
        postPatch = ''
          patchShebangs resources/niri-session
        '';
      });
  };
}
