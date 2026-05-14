{
  flake.homeModules.hmEnv =
    { config, ... }:
    {
      home.sessionSearchVariables = {
        PATH = [
          "${config.home.homeDirectory}/.local/bin"
          "${config.home.homeDirectory}/.local/bin/amber"
          "${config.home.sessionVariables.GOPATH}/bin"
        ];
      };

      home.sessionVariables = {
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
        XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";

        GOPATH = "${config.home.sessionVariables.XDG_DATA_HOME}/go";
        GOMODCACHE = "${config.home.sessionVariables.XDG_CACHE_HOME}/go/mod";
        GTK2_RC_FILES = "${config.home.sessionVariables.XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
        CARGO_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/cargo";
        RUSTUP_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/rustup";
        DOCKER_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/docker";
        MACHINE_STORAGE_PATH = "${config.home.sessionVariables.XDG_DATA_HOME}/machines";
        GRADLE_USER_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/gradle";
        FZF_DEFAULT_OPTS = "--layout=reverse --height 40% --color=16 --border --tmux=center";

        NIXCFG_DIR = "${config.home.homeDirectory}/.nixcfg";
        NH_FLAKE = "${config.home.sessionVariables.NIXCFG_DIR}";
        DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
      };
    };
}
