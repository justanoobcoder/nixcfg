{
  boot = {
    # UUID of / partition
    resumeDevice = "/dev/disk/by-uuid/36db1072-6ed0-4493-bddd-c56bd7c047ad";

    # To get resume_offset value:
    # If ext4: filefrag -v swap_file | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
    # If btrfs: btrfs inspect-internal map-swapfile -r swap_file
    kernelParams = [
      "resume_offset=1211539"
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];
    initrd.systemd.enable = true;
  };
}
