{pkgs, ...}: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [pkgs.qt6Packages.fcitx5-unikey];
        waylandFrontend = true;
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "unikey";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "unikey";
          };
          globalOptions = {
            Behavior = {
              ActiveByDefault = false;
            };
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              EnumerateSkipFirst = false;
              ModifierOnlyKeyTimeout = 250;
            };
            "Hotkey/TriggerKeys" = {
              "0" = "Super+space";
            };
          };
        };
      };
    };
  };
}
