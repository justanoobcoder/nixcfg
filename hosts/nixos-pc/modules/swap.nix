{
  boot = {
    resumeDevice = "/dev/nvme0n1p6";
    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=20"
      "zswap.shrinker_enabled=1"
    ];
    initrd.systemd.enable = true;
  };
}
