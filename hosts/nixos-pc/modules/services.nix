{
  services.cloudflare-warp.enable = true;
  services.speechd.enable = true;
  services.syncthing = {
    enable = true;
    user = "hiepnh";
    group = "users";
    dataDir = "/var/lib/syncthing-data";
    openDefaultPorts = true;
  };
}
