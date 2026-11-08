{ inputs, self, ... }:
{
  flake.nixosModules.vietnameseInputMethod =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.vietnameseInputMethod;

      # Runs every binary of `pkg` with the fcitx5-gtk im module instead of
      # GTK's text-input-v3 one. No rebuild: symlinks plus wrapper scripts.
      withFcitxImModule =
        pkg:
        pkgs.symlinkJoin {
          name = "${lib.getName pkg}-fcitx-im";
          paths = [ pkg ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            for f in $out/bin/*; do
              wrapProgram "$f" --set GTK_IM_MODULE fcitx
            done
          '';
        };
    in
    {
      imports = [
        inputs.fcitx5-lotus.nixosModules.fcitx5-lotus
      ];

      options.vietnameseInputMethod.fcitxImModuleApps = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = ''
          GTK apps that type through the fcitx5-gtk im module (DBus) instead of
          text-input-v3. Over text-input-v3 a click does not end the preedit:
          LibreOffice moves it to the click.
        '';
      };

      config = {
        services.fcitx5-lotus.enable = true;

        i18n = {
          inputMethod = {
            enable = true;
            type = "fcitx5";
            fcitx5 = {
              addons = [
                self.packages.${pkgs.stdenv.hostPlatform.system}.fcitx5-areca
                inputs.fcitx5-jot.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];
              waylandFrontend = true;
            };
          };
        };

        vietnameseInputMethod.fcitxImModuleApps = [
          # libreoffice
        ];
        environment.systemPackages = map withFcitxImModule cfg.fcitxImModuleApps;

        hardware.uinput.enable = true;
      };
    };
}
