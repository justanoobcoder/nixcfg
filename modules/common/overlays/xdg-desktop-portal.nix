{
  flake.overlays.xdg-desktop-portal = _: prev: {
    xdg-desktop-portal = prev.xdg-desktop-portal.overrideAttrs (_: {
      doCheck = false;
    });
  };
}
