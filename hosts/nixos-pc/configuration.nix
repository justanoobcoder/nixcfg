{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  networking.hostName = "nixos-pc";

  nixpkgs.config.allowUnfree = true;

  # To run AppImage easily
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11";
}
