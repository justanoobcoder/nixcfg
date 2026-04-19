{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.wlctl = pkgs.stdenv.mkDerivation rec {
      pname = "wlctl";
      version = "0.1.5";

      src = pkgs.fetchurl {
        url = "https://github.com/aashish-thapa/wlctl/releases/download/v${version}/wlctl-x86_64-unknown-linux-musl";
        hash = "sha256-TAccnrHKwvRHNIN7vEAJXdPxHH9NGGGbuSnnAdFo+1w=";
      };

      dontUnpack = true;
      dontBuild = true;

      installPhase = ''
        install -Dm755 $src $out/bin/wlctl
      '';

      propagatedBuildInputs = [
        pkgs.networkmanager
      ];

      meta = with lib; {
        description = "TUI for managing WiFi using NetworkManager (fork of impala)";
        homepage = "https://github.com/aashish-thapa/wlctl";
        license = licenses.gpl3Only;
        platforms = platforms.linux;
        mainProgram = "wlctl";
      };
    };
  };
}
