{
  flake.homeModules.git = {
    lib,
    config,
    ...
  }: {
    options.hm.git = {
      userName = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      userEmail = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      defaultBranch = lib.mkOption {
        type = lib.types.str;
        default = "main";
      };
    };

    config = lib.mkIf (config.hm.git.userName != "") {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = config.hm.git.userName;
            email = config.hm.git.userEmail;
          };
          init.defaultBranch = config.hm.git.defaultBranch;
        };
      };
    };
  };
}
