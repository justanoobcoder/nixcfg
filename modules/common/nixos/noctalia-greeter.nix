{
  flake.nixosModules.noctaliaGreeter = { pkgs, ... }: {
    services.displayManager.noctalia-greeter = {
      enable = true;
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
