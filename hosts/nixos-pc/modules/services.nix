{pkgs, ...}: {
  services.cloudflare-warp.enable = true;

  systemd.services.power-profile-on-boot = {
    description = "Set power profile and brightness based on AC state at boot";
    wantedBy = ["multi-user.target"];
    after = ["power-profiles-daemon.service"];
    wants = ["power-profiles-daemon.service"];
    serviceConfig.Type = "oneshot";

    script = ''
      AC=$(cat /sys/class/power_supply/AC/online 2>/dev/null || echo 1)

      if [ "$AC" = "0" ]; then
        ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
        ${pkgs.brightnessctl}/bin/brightnessctl set 40%
      else
        ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
        ${pkgs.brightnessctl}/bin/brightnessctl set 100%
      fi
    '';
  };

  systemd.services.power-profile-on-ac-change = {
    description = "Update power profile and brightness on AC change";
    requires = ["power-profiles-daemon.service"];
    serviceConfig.Type = "oneshot";

    script = ''
      AC=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)

      if [ "$AC" = "0" ]; then
        ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
        ${pkgs.brightnessctl}/bin/brightnessctl set 40%
      else
        ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
        ${pkgs.brightnessctl}/bin/brightnessctl set 100%
      fi
    '';
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", TAG+="systemd", \
      ENV{SYSTEMD_WANTS}="power-profile-on-ac-change.service"
  '';
}
