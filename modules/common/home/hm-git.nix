{
  flake.homeModules.hmGit =
    {
      lib,
      config,
      ...
    }:
    {
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
        signingKey = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        signingFormat = lib.mkOption {
          type = lib.types.enum [
            "openpgp"
            "ssh"
            "x509"
          ];
          default = "openpgp";
        };
      };
      config = lib.mkIf (config.hm.git.userName != "") {
        programs.git = {
          enable = true;
          signing = lib.mkIf (config.hm.git.signingKey != "") {
            format = config.hm.git.signingFormat;
            key = config.hm.git.signingKey;
            signByDefault = true;
          };
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
