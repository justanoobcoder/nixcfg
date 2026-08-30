{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.fcitx5-areca = pkgs.stdenv.mkDerivation rec {
        pname = "fcitx5-areca";
        version = "5.0.2";

        src = pkgs.fetchFromGitHub {
          owner = "xhkzeroone";
          repo = "ArecaIME";
          tag = "v${version}";
          hash = "sha256-kunM0BfjQHTk0s+3AyJqg38aFSltyZBQ+NZmHqn7pkM=";
        };
        # src = /home/hiepnh/Projects/ArecaIME;

        bambooCore = pkgs.fetchFromGitHub {
          owner = "BambooEngine";
          repo = "bamboo-core";
          rev = "b2e49a2b48c7d3772a3673142a7747eccd9d5f79";
          hash = "sha256-AZNUZo0zqrjYwAgJl6Ubd3Qil5VuJk0uWPsnfu8M3wg=";
        };

        postUnpack = ''
          mkdir -p $sourceRoot/bamboo
          rm -rf $sourceRoot/bamboo/bamboo-core
          cp -r $bambooCore $sourceRoot/bamboo/bamboo-core
          chmod -R u+w $sourceRoot/bamboo/bamboo-core
        '';

        nativeBuildInputs = with pkgs; [
          cmake
          go
          pkg-config
        ];

        buildInputs = [
          pkgs.fcitx5
        ];

        preBuild = ''
          export GOPROXY=off
        '';

        meta = with lib; {
          description = "Areca is a Vietnamese input method editor for Fcitx5";
          homepage = "https://github.com/xhkzeroone/ArecaIME";
          license = licenses.mit;
          platforms = platforms.linux;
        };
      };
    };
}
