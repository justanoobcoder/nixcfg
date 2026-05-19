{
  flake.homeModules.hmHypridle = _: {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "sleep 3s; powerprofilesctl set balanced";
          before_sleep_cmd = "powerprofilesctl set power-saver; noctalia-shell ipc call lockScreen lock";
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
        };

        listener = [
          # turn off keyboard backlight after 10 seconds of inactivity
          {
            timeout = 10;
            on-timeout = "brightnessctl -sd platform::kbd_backlight set 0";
            on-resume = "brightnessctl -rd platform::kbd_backlight";
          }
          # dim screen after 5 minutes of inactivity
          {
            timeout = 300;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          # lock screen after 6 minutes of inactivity
          {
            timeout = 360;
            on-timeout = "noctalia-shell ipc call lockScreen lock";
          }
          # turn off screen after 10 minutes of inactivity
          {
            timeout = 600;
            on-timeout = "powerprofilesctl set power-saver; hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
            on-resume = "powerprofilesctl set balanced; hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r";
          }
          # suspend after 20 minutes of inactivity
          {
            timeout = 1200;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
