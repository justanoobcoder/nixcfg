{
  flake.overlays.fastfetch = _: prev: {
    fastfetch = prev.fastfetch.overrideAttrs (_: rec {
      version = "2.62.1";
      src = prev.fetchFromGitHub {
        owner = "fastfetch-cli";
        repo = "fastfetch";
        rev = version;
        hash = "sha256-lI3p0LPDg5EXQ60NIYkpv0sNeckUdZjJSsmc2XP1l0E=";
      };
      postPatch = "";
    });
  };
}
