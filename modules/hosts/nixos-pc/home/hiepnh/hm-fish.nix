{
  flake.homeModules.hmFish =
    { config, ... }:
    {
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
            if test "$SHLVL" -eq 1
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

            if [ -n "$file" ]
                set prev_dir $PWD
                cd (dirname $file)
                $EDITOR $file
                cd $prev_dir
            end
          '';

          cfh = ''
            if [ -n "$file" ]
                set prev_dir $PWD
                cd (dirname $file)
                $EDITOR $file
                cd $prev_dir
            end
          '';

          cfn = ''
            if [ -n "$file" ]
                set prev_dir $PWD
                cd (dirname $file)
                $EDITOR $file
                cd $prev_dir
            end
          '';

          cfz = ''
            set file (find ${config.home.sessionVariables.DOTFILES_DIR}/.config/zsh -type f | fzf --exact)

            if [ -n "$file" ]
                set prev_dir $PWD
                cd (dirname $file)
                $EDITOR $file
                cd $prev_dir
            end
          '';
        };
      };
    };
}
