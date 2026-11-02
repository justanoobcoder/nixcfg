{
  flake.nixosModules.numlock =
    {
      pkgs,
      ...
    }:
    {
      systemd.services.numlock-on-tty = {
        description = "Enable NumLock on all VTs";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = pkgs.writeShellScript "numlock-on-tty" ''
            for tty in /dev/tty{1..6}; do
              ${pkgs.kbd}/bin/setleds -D +num < "$tty" > /dev/null 2>&1 || true
            done
          '';
        };
      };

      programs.ydotool.enable = true;
      users.users.hiepnh.extraGroups = [ "ydotool" ];

      systemd.user.services.numlock-on-graphical = {
        description = "Enable NumLock on graphical session start";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
          ExecStart = pkgs.writeShellScript "numlock-check-graphical" ''
            led=$(cat /sys/class/leds/input*::numlock/brightness 2>/dev/null | head -1)
            if [ "$led" = "0" ]; then
              ${pkgs.ydotool}/bin/ydotool key 69:1 69:0
            fi
          '';
        };
      };
    };
}
