{
  flake.nixosModules.nixosPcSuspendHibernate =
    { config, ... }:
    let
      # Physical offset of the swapfile, for hibernation:
      # `btrfs inspect-internal map-swapfile -r /swap/swapfile`.
      resumeOffset = 7388932;
    in
    {
      assertions = [
        {
          assertion = resumeOffset != null;
          message = "Set resumeOffset in modules/hosts/nixos-pc/features/suspend-hibernate.nix (see docs/btrfs.md).";
        }
      ];

      # Created at install time with `btrfs filesystem mkswapfile --size 16g /swap/swapfile`,
      # which makes it nocow and uncompressed as btrfs requires; no `size`, so NixOS leaves it alone.
      swapDevices = [ { device = "/swap/swapfile"; } ];

      boot = {
        # the swapfile lives on the btrfs partition, in @swap
        resumeDevice = config.fileSystems."/swap".device;

        kernel.sysctl = {
          "vm.swappiness" = 20;
        };

        kernelParams = [
          "resume_offset=${toString resumeOffset}"
          "mem_sleep_default=s2idle"
          "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
          "nvidia.NVreg_TemporaryFilePath=/var/tmp"
          "zswap.enabled=1"
          "zswap.compressor=zstd"
          "zswap.max_pool_percent=20"
          "zswap.shrinker_enabled=1"
        ];
        # initrd.systemd.enable = true;
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
