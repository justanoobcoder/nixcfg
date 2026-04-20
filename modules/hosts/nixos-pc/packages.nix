{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.packages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # desktop
      kitty
      app2unit
      discord
      wl-clipboard
      mpv
      imv
      neovide
      antigravity
      pcmanfm-qt
      wtype
      telegram-desktop
      obs-studio
      keepassxc
      qogir-icon-theme
      brightnessctl
      easyeffects
      gimp
      grim
      slurp
      swappy
      gpu-screen-recorder
      obsidian
      kdePackages.qt6ct
      libsForQt5.qt5ct
      adw-gtk3
      tela-circle-icon-theme
      code-cursor
      lutris
      blobdrop
      zed-editor-fhs
      kdePackages.okular
      jetbrains-toolbox
      postman
      winboat

      # cli
      yazi
      stow
      amber-lang
      btop
      google-cloud-sdk
      devenv
      nh
      fastfetch
      lazygit
      eza
      starship
      fzf
      killall
      zoxide
      direnv
      git
      tree
      curl
      wget
      gnutar
      unzip
      bat
      jq
      fd
      ripgrep
      inetutils
      cachix

      self.packages.${pkgs.stdenv.hostPlatform.system}.wlctl

      inputs.noobvim.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
