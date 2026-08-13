{
  flake.nixosModules.noctaliaGreeter = { inputs, pkgs, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
      greeter-args = "";
      settings = {
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 15;
          path = "${pkgs.bibata-cursors}/share/icons";
        };
        appearance = {
          scheme = "Synced";
          theme_mode = "dark";
          password_style = "random";
          hide_logo = true;
        };
        auth = {
          allow_empty_password = false;
        };
      };
    };
  };
}
