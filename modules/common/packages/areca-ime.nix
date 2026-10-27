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
        version = "8.2.3";

        src = pkgs.fetchFromGitHub {
          owner = "xhkzeroone";
          repo = "ArecaIME";
          tag = "v${finalAttrs.version}";
          hash = "sha256-feetUHSoXdtAV30EIx5y9PLAwsgvibhz6kISRz+3hC4=";
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
