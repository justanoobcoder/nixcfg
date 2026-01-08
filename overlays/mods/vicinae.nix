{prev}:
prev.vicinae.overrideAttrs (oldAttrs: rec {
  version = "0.18.2";
  src = prev.fetchFromGitHub {
    owner = "vicinaehq";
    repo = "vicinae";
    tag = "v${version}";
    hash = "sha256-OPBgcM2ZzbVEUS6lwRpJo2JBfiRK8TmYVSmZImEW2gA=";
  };
})
