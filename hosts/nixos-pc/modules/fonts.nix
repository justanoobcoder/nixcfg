{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    liberation_ttf
    font-awesome
    nerd-fonts.jetbrains-mono
  ];
}
