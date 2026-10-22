{ inputs, ... }:
{
  flake.nixosModules.cachyosKernel =
    {
      pkgs,
      lib,
      ...
    }:
    {
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];

      boot.kernelPackages = pkgs.linuxPackagesFor (
        pkgs.cachyosKernels.linux-cachyos-bore-lto-x86_64-v3.override {
          structuredExtraConfig = builtins.mapAttrs (_: lib.mkForce) (
            with lib.kernel;
            {
              # Disable AMD CPU / Platform features (Machine has Intel i5-12450HX)
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

              # Disable AMD GPU Drivers (Machine has Nvidia RTX 4050)
              DRM_AMDGPU = no;
              DRM_RADEON = no;

              # Disable Open-source Nouveau driver (Machine uses proprietary nvidia driver)
              DRM_NOUVEAU = no;

              # Disable Virtualization guest drivers (Machine is bare-metal Lenovo LOQ)
              HYPERV = no;
              XEN = no;
              VMWARE_VMCI = no;
              VMWARE_BALLOON = no;
              VMWARE_PVSCSI = no;
              VMXNET3 = no;

              # Disable Enterprise cluster interconnects & Apple platform
              INFINIBAND = no;
              APPLE_GMUX = no;
              SENSORS_APPLESMC = no;

              # Disable Wi-Fi vendors (Machine only has Realtek RTL8852BE / rtw89)
              WLAN_VENDOR_INTEL = no;
              WLAN_VENDOR_ATH = no; # Qualcomm / Atheros (ath9k, ath10k, ath11k, ath12k)
              WLAN_VENDOR_BROADCOM = no; # Broadcom (b43, brcmfmac)
              WLAN_VENDOR_MEDIATEK = no; # MediaTek (mt76, mt7921, mt7996, etc.)
              WLAN_VENDOR_MARVELL = no;
              WLAN_VENDOR_TI = no;
              WLAN_VENDOR_ZYDAS = no;
              WLAN_VENDOR_QUANTENNA = no;

              # Disable Ethernet vendors (Machine only has Realtek RTL8168 / r8169)
              NET_VENDOR_INTEL = no; # Intel e1000e, igb, ixgbe, i40e, ice, igc
              NET_VENDOR_MELLANOX = no; # Mellanox mlx4, mlx5 10G/40G/100G NICs
              NET_VENDOR_BROADCOM = no; # Broadcom tg3, bnx2, bnxt
              NET_VENDOR_CHELSIO = no;
              NET_VENDOR_CISCO = no;
              NET_VENDOR_AQUANTIA = no;
              NET_VENDOR_SOLARFLARE = no;
              NET_VENDOR_AMD = no;

              # Module Compression (Switch from XZ to ZSTD)
              MODULE_COMPRESS_XZ = no;
              MODULE_COMPRESS_ZSTD = yes;
            }
          );

          ignoreConfigErrors = true;
        }
      );
    };
}
