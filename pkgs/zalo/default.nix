{ lib
, appimageTools
, fetchurl
}:

let
  version = "25.11.20";
  pname = "zalo";

  src = fetchurl {
    url = "https://github.com/doandat943/zalo-for-linux/releases/download/${version}/Zalo-${version}+ZaDark-25.10-b38f07c.AppImage";
    sha256 = "sha256-fNq0IiP05Fch1HXJzxk+GvOl6+s8OhDA89wi5CcRc28=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications

    cp ${appimageContents}/zalo-for-linux.desktop $out/share/applications/${pname}.desktop

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${meta.mainProgram}'

    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp ${appimageContents}/usr/share/icons/hicolor/512x512/apps/zalo-for-linux.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Icon=zalo-for-linux' 'Icon=${pname}'
  '';

  meta = {
    description = "Unofficial port of Zalo messaging application for Linux systems.";
    homepage = "https://zalo.me";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "zalo";
  };
}
