{ pkgs, ... }:
{
  users.users.hiepnh = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "input" "power" "audio" "video" "networkmanager" ];
    packages = with pkgs; [];
  };
}
