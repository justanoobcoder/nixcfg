{
  programs.zsh = {
    enable = true;
    shellInit = "export ZDOTDIR=$HOME/.config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
