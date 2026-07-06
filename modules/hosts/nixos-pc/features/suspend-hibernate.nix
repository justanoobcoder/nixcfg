{
  flake.nixosModules.suspendHibernate = _: {
    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 10 * 1024;
      }
    ];

    boot = {
      # UUID of / partition
      resumeDevice = "/dev/disk/by-uuid/66699bf2-70c1-4ddc-8180-4553254dfe67";

      kernel.sysctl = {
        "vm.swappiness" = 20;
      };

      # resume_offset is only for swapfile, to get resume_offset value:
      # If ext4: filefrag -v /path/to/swap_file | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
      # If btrfs: btrfs inspect-internal map-swapfile -r /path/to/swap_file
      kernelParams = [
        "resume_offset=49051648"
        "mem_sleep_default=s2idle"
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "nvidia.NVreg_TemporaryFilePath=/var/tmp"
        "zswap.enabled=1"
        "zswap.compressor=zstd"
        "zswap.max_pool_percent=20"
        "zswap.shrinker_enabled=1"
      ];
      initrd.systemd.enable = true;
    };
    systemd.sleep.settings.Sleep = {
      AllowSuspend = "yes";
      AllowHibernation = "yes";
      AllowHybridSleep = "no";
      AllowSuspendThenHibernate = "no";
    };
    powerManagement.enable = true;
  };
}
