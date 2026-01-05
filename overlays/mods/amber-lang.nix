{prev}:
prev.amber-lang.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "0.5.1-alpha";

  src = prev.fetchFromGitHub {
    owner = "amber-lang";
    repo  = "amber";
    tag   = version;
    hash = "sha256-v1uJe3vVGKXaZcQzdoYzu/bJKMQnS4IYET4QLPW+J8Y=";
  };

  patches = [];

  cargoDeps = prev.rustPlatform.fetchCargoVendor {
    inherit pname src version;
    hash = "sha256-aXcxlmmDYLFbyRJYyGE1gbQMbdysHx4iWXsrUj10Eco=";
  };
  cargoHash = "sha256-aXcxlmmDYLFbyRJYyGE1gbQMbdysHx4iWXsrUj10Eco=";
})
