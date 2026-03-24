{pkgs, ...}: {
  services = {
    udisks2.enable = true;

    cloudflare-warp.enable = true;
    udev.extraRules = let
      powerScript = pkgs.writeShellScript "power-profile-change" ''
        AC=$(cat /sys/class/power_supply/AC*/online | head -n 1)

        if [ "$AC" = "0" ]; then
          ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
          ${pkgs.brightnessctl}/bin/brightnessctl set 40%
        else
          ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
          ${pkgs.brightnessctl}/bin/brightnessctl set 100%
        fi
      '';
    in ''
      SUBSYSTEM=="power_supply", ACTION=="change", RUN+="${powerScript}"
    '';
  };

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

  systemd.services.trigger-udev-power = {
    description = "Trigger udev power rules at boot";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.systemd}/bin/udevadm trigger --subsystem-match=power_supply --action=change";
    };
  };
}
