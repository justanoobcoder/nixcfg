{ self, ... }:
{
  # What every host imports: nix itself, locale, home-manager and the login shells.
  flake.nixosModules.bundleBase =
    { lib, ... }:
    {
      imports = [
        self.nixosModules.homeManager
        self.nixosModules.zsh
        self.nixosModules.fish
        self.nixosModules.tack
      ];

      # Common modules that act on one user (greeter, input method, ...) read this
      # instead of naming the user.
      options.nixcfg.primaryUser = lib.mkOption {
        type = lib.types.str;
        description = "The host's main user.";
      };

      config = {
        nix.settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          substituters = [
            "https://justanoobcoder.cachix.org"
          ];
          trusted-public-keys = [
            "justanoobcoder.cachix.org-1:D2/vJZSn8o8Fpsxzbjc9tHo2/D1ejBUqc4r71UvDVyk="
          ];
        };

        time.timeZone = lib.mkDefault "Asia/Ho_Chi_Minh";

        i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

        environment.sessionVariables = {
          EDITOR = "jon";
        };
      };
    };
}
