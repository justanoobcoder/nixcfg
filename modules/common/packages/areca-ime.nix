{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    let
      settingsPython = pkgs.python3.withPackages (ps: [ ps.pygobject3 ]);
    in
    {
      packages.fcitx5-areca = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "fcitx5-areca";
        version = "8.3.22";

        src = pkgs.fetchFromGitHub {
          owner = "xhkzeroone";
          repo = "ArecaIME";
          # tag = "v${finalAttrs.version}";
          rev = "99a2e3229a938d9a363360110d89202655071415";
          # hash = "sha256-VCqjOkcGG9VVSPFi/lnoZeOzj60leZRIR5HR3wbPzfw=";
          hash = "sha256-VXizF7nAeKzdWL/Wbz0mIUqHGQVDb6K2WuvAdL1hbic=";
          fetchSubmodules = true;
        };

        nativeBuildInputs = with pkgs; [
          cmake
          go
          ninja
          pkg-config
          wayland-scanner
          wrapGAppsHook4
          gobject-introspection
        ];

        buildInputs = with pkgs; [
          dbus
          fcitx5
          libei
          libinput
          libportal
          udev
          wayland
          gtk4
          gdk-pixbuf
          librsvg
        ];

        postPatch = ''
          substituteInPlace data/areca-settings-launcher.in \
            --replace-fail "exec python3" "exec ${settingsPython}/bin/python3"
        '';

        preConfigure = ''
          export GOCACHE=$TMPDIR/go-cache
          export GOPATH=$TMPDIR/go
          export GOPROXY=off
        '';

        cmakeFlags = [
          "-DCMAKE_BUILD_TYPE=Release"
        ];

        doCheck = false;

        preFixup = ''
          gappsWrapperArgs+=(--prefix PATH : ${lib.makeBinPath [ pkgs.fcitx5 ]})
        '';

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
