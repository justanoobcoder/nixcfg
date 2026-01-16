{ pkgs, ...}:
{
  programs.gnupg = {
    agent.enable = true;
    agent.pinentryPackage = pkgs.pinentry-curses;
  };
}
