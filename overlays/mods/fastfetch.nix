{prev}:
prev.fastfetch.overrideAttrs (oldAttrs: {
  version = "2.34.0";
  src = prev.fetchFromGitHub {
    owner = "fastfetch-cli";
    repo = "fastfetch";
    rev = "2.34.0";
    hash = "sha256-ZTtDYUnLp8IzGluJXLCHBxHCZAXxO+akUkPOCPMdA5w=";
  };
  postPatch = "";
})
