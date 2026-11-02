{
  flake.homeModules.hmFish =
    { config, ... }:
    let
      # Zalo blocks shutdown, so kill it first
      killZalo = "ps aux | grep Zalo | grep -v grep | awk '{print $2}' | xargs kill -9 2>/dev/null; ";
    in
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
            # if test "$SHLVL" -eq 1
              if test -n "$DISPLAY" || test -n "$WAYLAND_DISPLAY"
                if test -f ~/.face
                  fastfetch --logo-type sixel --logo ~/.face --logo-padding-top 3
                else
                  fastfetch
                end
              else
                fastfetch
              end
            # end
          end

          starship init fish | source
        '';
        shellAliases = {
          cl = "clear";
          v = "nvim";
          y = "yazi";
          ls = "eza --group-directories-last";
          ll = "ls -lbg --icons always";
          la = "ls -a";
          lla = "ll -a";
          grep = "grep --color=auto";
          fgrep = "grep --color=auto";
          egrep = "grep --color=auto";
          sd = "${killZalo}shutdown -h now";
          rb = "${killZalo}shutdown -r now";
          g = "lazygit";
          gd = "lazygit -w $DOTFILES_DIR";
          ts = "tmux-sessionizer";
          ripdrag = "GSK_RENDERER=gl command ripdrag";
          clean-up = "nh clean all -a --keep 2";
        };

        # pick a file under a dotfiles directory with fzf and open it in $EDITOR
        functions =
          let
            dotfiles = config.home.sessionVariables.DOTFILES_DIR;
            editIn = dir: findArgs: ''
              set file (find ${dotfiles}/${dir} -type f ${findArgs}| fzf --exact)

              if [ -n "$file" ]
                  set prev_dir $PWD
                  cd (dirname $file)
                  $EDITOR $file
                  cd $prev_dir
              end
            '';
          in
          {
            fb = editIn ".local/bin" "";
            cfh = editIn ".config/hypr" "";
            cfu = editIn ".config/umbriel" "";
            cfn = editIn ".config/niri" "-not -path '*/dms/*' ";
            cfz = editIn ".config/zsh" "";
          };
      };

      programs.nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
      };
    };
}
