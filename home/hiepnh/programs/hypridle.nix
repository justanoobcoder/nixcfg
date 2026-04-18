{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "sleep 3s; powerprofilesctl set balanced";
        before_sleep_cmd = "powerprofilesctl set power-saver; loginctl lock-session";
        lock_cmd = "dms ipc call lock lock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 360;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "powerprofilesctl set power-saver; niri msg action power-off-monitors";
          on-resume = "powerprofilesctl set balanced";
        }
        {
          timeout = 1200;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
