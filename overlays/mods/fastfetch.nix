{prev}:
prev.fastfetch.overrideAttrs (oldAttrs: rec {
  version = "2.57.0";
  src = prev.fetchFromGitHub {
    owner = "fastfetch-cli";
    repo = "fastfetch";
    rev = "2.57.0";
    hash = "sha256-bdzD+od+KyEqkFixqGf/7O//1nHO9i0jzg65NRDIN7I=";
  };
  postPatch = "";
})
