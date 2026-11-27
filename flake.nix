{
  description = "My NixOS configuration";

  # Inputs are pinned by tack in .tack/pins.toml, not here.
  outputs =
    { self, ... }:
    let
      # flake-parts builds inputs' from self.inputs, which is empty without an inputs block.
      self' = self // {
        inherit inputs;
      };
      inputs = (import ./.tack) { } // {
        self = self';
      };
    in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      self = self';
    } (inputs.import-tree ./modules);
}
