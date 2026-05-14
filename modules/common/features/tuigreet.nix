{
  flake.nixosModules.tuigreet = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --greeting 'Hey, YOU. Stay away from my computer!' --remember --cmd 'uwsm start hyprland.desktop'";
          user = "greeter";
        };
      };
    };

    nixpkgs.overlays = [
      (_: prev: {
        tuigreet = let
          newSrc = prev.fetchFromGitHub {
            owner = "NotAShelf";
            repo = "tuigreet";
            tag = "0.10.2";
            hash = "sha256-jeelrp9r/V8540qKoCofD8wz/w/qBcubs72HkremhME=";
          };
        in
          prev.tuigreet.overrideAttrs {
            src = newSrc;
            cargoDeps = prev.rustPlatform.fetchCargoVendor {
              src = newSrc;
              hash = "sha256-B5Qxwv8jdpGJwXTEm5c12kvb6fri7H1AL2w640xQXVQ=";
            };
          };
      })
    ];
  };
}
