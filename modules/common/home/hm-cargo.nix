{
  flake.homeModules.hmCargo =
    { config, pkgs, ... }:
    {
      home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";

      xdg.dataFile."cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config.toml" {
        profile.dev = {
          # Debug info is most of target/debug; keep backtraces, drop the rest.
          debug = "line-tables-only";
        };
      };
    };
}
