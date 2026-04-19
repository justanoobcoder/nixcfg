{
  flake.nixosModules.cloudflareWarp = _: {
    services.cloudflare-warp.enable = true;

    environment.etc."warp-proxy.pac" = {
      text = ''
        function FindProxyForURL(url, host) {
            if (isInNet(dnsResolve(host), "127.0.0.1", "255.255.255.255")) {
                return "DIRECT";
            }
            return "SOCKS5 127.0.0.1:40000; DIRECT";
        }
      '';
      mode = "0644";
    };
  };
}
