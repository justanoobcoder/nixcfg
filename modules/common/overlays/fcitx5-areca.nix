{
  flake.overlays.fcitx5-areca =
    _: prev:
    let
      bambooCore = prev.fetchFromGitHub {
        owner = "BambooEngine";
        repo = "bamboo-core";
        rev = "b2e49a2b48c7d3772a3673142a7747eccd9d5f79";
        hash = "sha256-AZNUZo0zqrjYwAgJl6Ubd3Qil5VuJk0uWPsnfu8M3wg=";
      };
    in
    {
      fcitx5-areca = prev.fcitx5-areca.overrideAttrs (old: rec {
        version = "5.0.2";

        src = prev.fetchFromGitHub {
          owner = "xhkzeroone";
          repo = "ArecaIME";
          tag = "v${version}";
          hash = "sha256-kunM0BfjQHTk0s+3AyJqg38aFSltyZBQ+NZmHqn7pkM=";
        };

        postUnpack = (old.postUnpack or "") + ''
          mkdir -p $sourceRoot/bamboo
          rm -rf $sourceRoot/bamboo/bamboo-core
          cp -r ${bambooCore} $sourceRoot/bamboo/bamboo-core
          chmod -R u+w $sourceRoot/bamboo/bamboo-core
        '';
      });
    };
}
