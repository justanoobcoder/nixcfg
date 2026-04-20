{
  flake.nixosModules.zsh = _: {
    programs.zsh = {
      enable = true;
      shellInit = ''
        export ZDOTDIR=$HOME/.config/zsh
        if [ -f /run/agenix/cachixAuthToken ]; then
          export CACHIX_AUTH_TOKEN=$(cat /run/agenix/cachixAuthToken)
        fi
      '';
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };
  };
}
