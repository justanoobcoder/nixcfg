{
  flake.overlays.gpu-screen-recorder = _: prev: {
    gpu-screen-recorder = prev.gpu-screen-recorder.overrideAttrs (_: rec {
      version = "5.13.9";
      src = prev.fetchgit {
        url = "https://repo.dec05eba.com/gpu-screen-recorder";
        tag = version;
        hash = "sha256-rGjS21eY2XfcdRwmKE2hJO1+FIXAmmBJ4y2oKgSwoRM=";
      };
      postPatch = "";

      mesonFlags = [
        # Install the upstream systemd unit
        (prev.lib.mesonBool "systemd" true)
        # Enable Wayland support
        (prev.lib.mesonBool "portal" true)
        # Handle by the module
        (prev.lib.mesonBool "capabilities" false)
        (prev.lib.mesonBool "nvidia_suspend_fix" false)
      ];
    });
  };
}
