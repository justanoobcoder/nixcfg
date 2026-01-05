{ prev }:
prev.vicinae.overrideAttrs (oldAttrs: rec {
  version = "0.18.1";
  src = prev.fetchFromGitHub {
    owner = "vicinaehq";
    repo = "vicinae";
    tag = "v${version}";
    hash = "sha256-I7FKl8r8xtDfQVo4kkYQEKsxpFhSRZUak67LEHmSyY8=";
  };
})
