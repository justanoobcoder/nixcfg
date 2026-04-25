{
  flake.overlays.openldap = _: prev: {
    openldap = prev.openldap.overrideAttrs (_: {
      doCheck = false;
    });
  };
}
