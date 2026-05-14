{
  flake.nixosModules.nixosPcHardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usbhid"
          "usb_storage"
          "sd_mod"
        ];
        initrd.kernelModules = [ ];
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/49d6e9ce-6eaf-423b-8b64-978d870a1451";
          fsType = "btrfs";
          options = [
            "subvol=root"
            "compress=zstd"
          ];
        };
        "/home" = {
          device = "/dev/disk/by-uuid/49d6e9ce-6eaf-423b-8b64-978d870a1451";
          fsType = "btrfs";
          options = [
            "subvol=home"
            "compress=zstd"
          ];
        };
        "/nix" = {
          device = "/dev/disk/by-uuid/49d6e9ce-6eaf-423b-8b64-978d870a1451";
          fsType = "btrfs";
          options = [
            "subvol=nix"
            "compress=zstd"
            "noatime"
          ];
        };
        "/swap" = {
          device = "/dev/disk/by-uuid/49d6e9ce-6eaf-423b-8b64-978d870a1451";
          fsType = "btrfs";
          options = [
            "subvol=swap"
            "noatime"
          ];
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/F59D-7D65";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      swapDevices = [
        {
          device = "/swap/swapfile";
          size = 10240;
        }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
