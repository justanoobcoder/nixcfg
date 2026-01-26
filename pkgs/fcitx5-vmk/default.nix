{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "fcitx5-vmk";
  version = "0.9.3alpha";

  src = pkgs.fetchFromGitHub {
    owner = "nhktmdzhg";
    repo = "VMK";
    rev = "main";
    sha256 = "sha256-13Vi99zbS6qc38dOyKpd66vAhUbEXDEBi+G/z0/LM0s=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    extra-cmake-modules
    pkg-config
    go
    gcc
    gettext
    hicolor-icon-theme
  ];

  buildInputs = with pkgs; [
    fcitx5
    libinput
    systemd
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

  installFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  meta = with pkgs.lib; {
    description = "Fcitx5 VMK input method";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

