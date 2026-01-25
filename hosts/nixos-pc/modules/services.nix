{pkgs, ...}: {
  services.cloudflare-warp.enable = true;

  services.udev.extraRules = let
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
