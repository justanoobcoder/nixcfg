{
  flake.homeModules.userHiepnhTheme = _: {
    # Read by libadwaita and the xdg-desktop-portal Settings interface (Firefox, Chromium, GTK4 apps).
    # The GTK/Qt config files are already dark; this value used to be written by noctalia.
    dconf.settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };
}
