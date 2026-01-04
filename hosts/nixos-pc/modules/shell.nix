{
  programs.zsh = {
    enable = true;
    shellInit = "export ZDOTDIR=/home/hiepnh/.config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
