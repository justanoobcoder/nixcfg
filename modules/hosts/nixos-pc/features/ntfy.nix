{
  flake.nixosModules.nixosPcNtfy = _: {
    services.tailscale.enable = true;

    services.ntfy-sh = {
      enable = true;
      settings = {
        listen-http = ":2586";
        # Replace with the machine's MagicDNS name after `tailscale up`
        # From: tailscale status --json | jq -r .Self.DNSName
        base-url = "http://nixos-pc.tail7fdfff.ts.net";
        behind-proxy = false;
      };
    };

    # Only reachable over Tailscale, not from LAN or the Internet
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 2586 ];
  };
}
