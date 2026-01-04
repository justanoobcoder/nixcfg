{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    gcc15
    gnutar
    unzip
    gpu-screen-recorder
  ];

}
