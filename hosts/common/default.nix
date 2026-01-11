{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };
  };
  boot.kernelParams = [
    "mem_sleep_default=s2idle"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
  ];
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
  powerManagement.enable = true;
  hardware.nvidia = {
    powerManagement = {
      enable = true;
      finegrained = false;
    };
    modesetting.enable = true;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = false;

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    openssh.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(control, esc)";
              esc = "capslock";
            };
          };
        };
      };
    };
  };

  nix.settings.download-buffer-size = 524288000;
}
