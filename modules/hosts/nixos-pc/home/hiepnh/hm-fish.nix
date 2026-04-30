{
  flake.homeModules.hmFish = {config, ...}: {
    programs.fish = {
      enable = true;
      shellInit = ''
        if test -f /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
          babelfish < /etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh | source
        end
      '';
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_visual block
        fzf --fish | source

        if command -q fastfetch
          if test -n "$DISPLAY" || test -n "$WAYLAND_DISPLAY"
            if test -f ~/.face
              fastfetch --logo ~/.face --logo-padding-top 3
            else
              fastfetch
            end
          else
            fastfetch
          end
        end

        starship init fish | source
      '';
      shellAliases = {
        cl = "clear";
        v = "nvim";
        ls = "eza --group-directories-last";
        ll = "ls -lbg --icons";
        la = "ls -a";
        lla = "ll -a";
        grep = "grep --color=auto";
        fgrep = "grep --color=auto";
        egrep = "grep --color=auto";
        sd = "ps aux | grep Zalo | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null; shutdown -h now";
        rb = "ps aux | grep Zalo | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null; shutdown -r now";
        g = "lazygit";
        gd = "lazygit -w $DOTFILES_DIR";
        ts = "tmux-sessionizer";
        clean-up = "nh clean all -a --keep 2";
      };

      functions = {
        fb = ''
          set file (find ${config.home.sessionVariables.DOTFILES_DIR}/.local/bin -type f | fzf --exact)
          [ -z "$file" ] || $EDITOR $file
        '';

        cfg = ''
          set file (find ${config.home.sessionVariables.DOTFILES_DIR}/.config/hypr -type f | fzf --exact)
          [ -z "$file" ] || $EDITOR $file
        '';

        cfn = ''
          set file (find ${config.home.sessionVariables.DOTFILES_DIR}/.config/niri -type f | fzf --exact)
          [ -z "$file" ] || $EDITOR $file
        '';

        cfz = ''
          set file (find ${config.home.sessionVariables.DOTFILES_DIR}/.config/zsh -type f | fzf --exact)
          [ -z "$file" ] || $EDITOR $file
        '';
      };
    };
  };
}
