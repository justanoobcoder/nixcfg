{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    killall
    tree
    git
    curl
    wget
    gcc15
    gnutar
    unzip
    bat
    jq
    fd
    ripgrep
    python313Packages.python
    inetutils
  ];
}
