{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, wayland
, wayland-scanner
, wayland-protocols
, cairo
, pango
, libinput
, libxkbcommon
, gtk3
, libappindicator-gtk3
}:

stdenv.mkDerivation rec {
  pname = "keypop";
  version = "r74-afbde2a";

  src = fetchFromGitHub {
    owner = "yossefsabry";
    repo = "keypop";
    rev = "abf96a433129e2b51f6067a3c2882745ef55314c";
    sha256 = "0q662ddvybk7dvwdny92mwvyff6wndgmndv8kfgq56f3dc9sm6c5";
  };

  nativeBuildInputs = [
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    wayland
    wayland-protocols
    cairo
    pango
    libinput
    libxkbcommon
    gtk3
    libappindicator-gtk3
  ];

  buildPhase = ''
    make
  '';

  patchPhase = ''
  substituteInPlace Makefile \
    --replace /usr/share/wayland-protocols \
              ${wayland-protocols}/share/wayland-protocols
'';

  installPhase = ''
    install -Dm755 keypop $out/bin/keypop
  '';

  meta = with lib; {
    description = "A simple Wayland key display application overlay";
    homepage = "https://github.com/yossefsabry/keypop";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "keypop";
  };
}
