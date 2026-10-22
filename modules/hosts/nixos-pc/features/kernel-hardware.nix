{
  flake.nixosModules.kernelHardwareNixosPc =
    { lib, ... }:
    {
      boot.kernelPatches = [
        {
          name = "nixos-pc-hardware-exclusions";
          patch = null;
          structuredExtraConfig = builtins.mapAttrs (_: lib.mkForce) (
            with lib.kernel;
            {
              # --- AMD CPU / Platform features (Machine has Intel i5-12450HX) ---
              MICROCODE_AMD = no;
              X86_AMD_PSTATE = no;
              AMD_MEM_ENCRYPT = no;
              KVM_AMD = no;
              CRYPTO_DEV_CCP = no;
              AMD_IOMMU = no;
              PERF_EVENTS_AMD_BRS = no;
              PERF_EVENTS_AMD_IOMMU = no;
              PERF_EVENTS_AMD_UNCORE = no;
              SENSORS_K10TEMP = no;
              SENSORS_FAM15H_POWER = no;
              EDAC_AMD64 = no;
              X86_AMD_PLATFORM_DEVICE = no;
              PINCTRL_AMD = no;

              # --- AMD GPU Drivers (Machine has Nvidia RTX 4050) ---
              DRM_AMDGPU = no;
              DRM_RADEON = no;

              # --- Open-source Nouveau driver (Machine uses proprietary nvidia driver) ---
              DRM_NOUVEAU = no;

              # --- Virtualization guest drivers (Machine is bare-metal Lenovo LOQ) ---
              HYPERV = no;
              XEN = no;
              VMWARE_VMCI = no;
              VMWARE_BALLOON = no;
              VMWARE_PVSCSI = no;
              VMXNET3 = no;

              # --- Enterprise cluster interconnects & Apple platform ---
              INFINIBAND = no;
              APPLE_GMUX = no;
              SENSORS_APPLESMC = no;

              # --- Wi-Fi vendors (Machine only has Realtek RTL8852BE / rtw89) ---
              WLAN_VENDOR_INTEL = no;
              WLAN_VENDOR_ATH = no; # Qualcomm / Atheros (ath9k, ath10k, ath11k, ath12k)
              WLAN_VENDOR_BROADCOM = no; # Broadcom (b43, brcmfmac)
              WLAN_VENDOR_MEDIATEK = no; # MediaTek (mt76, mt7921, mt7996, etc.)
              WLAN_VENDOR_MARVELL = no;
              WLAN_VENDOR_TI = no;
              WLAN_VENDOR_ZYDAS = no;
              WLAN_VENDOR_QUANTENNA = no;

              # --- Ethernet vendors (Machine only has Realtek RTL8168 / r8169) ---
              NET_VENDOR_INTEL = no; # Intel e1000e, igb, ixgbe, i40e, ice, igc
              NET_VENDOR_MELLANOX = no; # Mellanox mlx4, mlx5 10G/40G/100G NICs
              NET_VENDOR_BROADCOM = no; # Broadcom tg3, bnx2, bnxt
              NET_VENDOR_CHELSIO = no;
              NET_VENDOR_CISCO = no;
              NET_VENDOR_AQUANTIA = no;
              NET_VENDOR_SOLARFLARE = no;
              NET_VENDOR_AMD = no;

              # --- Thunderbolt / USB4 ---
              THUNDERBOLT = no;
              USB4 = no;
              INTEL_WMI_THUNDERBOLT = no;

              # --- Touchscreen and Joystick / Gamepad drivers ---
              INPUT_TOUCHSCREEN = no;
              INPUT_JOYSTICK = no;

              # --- Unused Filesystems (Only using EXT4, VFAT, NTFS) ---
              BTRFS_FS = no;
              XFS_FS = no;
              F2FS_FS = no;
              BCACHEFS_FS = no;
              NILFS2_FS = no;
              JFS_FS = no;
              REISERFS_FS = no;
              GFS2_FS = no;
              OCFS2_FS = no;
              ZONEFS_FS = no;

              # --- Legacy Hardware (Floppy, PCMCIA, Parallel port, FireWire) ---
              BLK_DEV_FD = no;
              PCCARD = no;
              PARPORT = no;
              FIREWIRE = no;

              # --- Obsolete 1990s SCSI host adapters ---
              SCSI_AIC7XXX = no;
              SCSI_AIC79XX = no;
              SCSI_BUSLOGIC = no;
              SCSI_ADVANSYS = no;
              SCSI_INIA100 = no;
              SCSI_QLOGIC_1280 = no;

              # --- Kernel Sanitizers (Safe: disable developer memory debugger) ---
              KASAN = no;
            }
          );
        }
      ];
    };
}
