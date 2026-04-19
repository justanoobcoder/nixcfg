final: prev: {
  custom = prev.custom or {} // {
    wlctl = prev.callPackage ./wlctl {};
  };
}
