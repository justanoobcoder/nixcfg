{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos-pc";

  # To run AppImage easily
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
