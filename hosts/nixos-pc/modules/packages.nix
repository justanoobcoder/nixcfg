{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    killall
    git
    curl
    wget
    gcc15
    gnutar
    unzip
    gpu-screen-recorder
  ];

}
