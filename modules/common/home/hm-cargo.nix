{
  flake.homeModules.hmCargo =
    { pkgs, ... }:
    {
      # CARGO_HOME is $XDG_DATA_HOME/cargo (see hm-env.nix), so this is its config.toml.
      xdg.dataFile."cargo/config.toml".source = (pkgs.formats.toml { }).generate "cargo-config.toml" {
        profile.dev = {
          # Debug info is most of target/debug; keep backtraces, drop the rest.
          debug = "line-tables-only";
        };
      };
    };
}
