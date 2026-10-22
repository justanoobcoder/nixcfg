{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.fcitx5-areca = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "fcitx5-areca";
        version = "8.1.7";

        src = pkgs.fetchFromGitHub {
          owner = "xhkzeroone";
          repo = "ArecaIME";
          tag = "v${finalAttrs.version}";
          hash = "sha256-2+llNIugmht9eeqgjlYSL8zrw8cGnMy7nkRXg2nC9As=";
          fetchSubmodules = true;
        };

        nativeBuildInputs = with pkgs; [
          cmake
          go
          ninja
          pkg-config
        ];

        buildInputs = with pkgs; [
          dbus
          fcitx5
          fontconfig
          libei
          libinput
          libportal
          libx11
          libxi
          libxtst
          sdl3
          udev
        ];

        preConfigure = ''
          export GOCACHE=$TMPDIR/go-cache
          export GOPATH=$TMPDIR/go
          export GOPROXY=off
        '';

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
        ];

        doCheck = false;

        meta = {
          description = "Vietnamese input method addon for Fcitx5";
          homepage = "https://github.com/xhkzeroone/ArecaIME";
          license = lib.licenses.mit;
          maintainers = with lib.maintainers; [ justanoobcoder ];
          platforms = lib.platforms.linux;
          mainProgram = "areca-settings";
        };
      });
    };
}
