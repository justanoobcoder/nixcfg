{ lib
, stdenv
, fetchurl
, networkmanager
}:

stdenv.mkDerivation rec {
  pname = "wlctl";
  version = "0.1.3";

  src = fetchurl {
    url = "https://github.com/aashish-thapa/wlctl/releases/download/v${version}/wlctl-x86_64-unknown-linux-musl";
    sha256 = "124fc6461675d1d3abdd3e984aebeb02868c32639bfcd7e4defb3b1df175d56e";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 $src $out/bin/wlctl
  '';

  propagatedBuildInputs = [
    networkmanager
  ];

  meta = with lib; {
    description = "TUI for managing WiFi using NetworkManager (fork of impala)";
    homepage = "https://github.com/aashish-thapa/wlctl";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    mainProgram = "wlctl";
  };
}
