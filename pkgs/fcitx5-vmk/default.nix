{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  pkg-config,
  go,
  gcc,
  gettext,
  hicolor-icon-theme,
  fcitx5,
  libinput,
  xorg,
  udev,
}:
stdenv.mkDerivation {
  pname = "fcitx5-vmk";
  version = "0.9.3alpha";

  src = fetchFromGitHub {
    owner = "nhktmdzhg";
    repo = "VMK";
    rev = "08818402994decceb2d3ac5f6abdbc8f72eea90a";
    sha256 = "sha256-AVA+Sh5D9L+QAwHiVzejy2h/Lc/RBfGuX+lP+JvcNdw=";
  };

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    pkg-config
    go
    gcc
    gettext
    hicolor-icon-theme
  ];

  buildInputs = [
    fcitx5
    libinput
    xorg.libX11
    udev
  ];

  dontUseCmakeConfigure = true;

  preBuild = ''
    export GOCACHE=$TMPDIR/go-cache
    export GOPATH=$TMPDIR/go
  '';

  buildPhase = ''
    runHook preBuild
    make build
    runHook postBuild
  '';

  installFlags = ["DESTDIR=$(out)" "PREFIX="];

  meta = with lib; {
    description = "Fcitx5 VMK input method";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
