{ inputs, self, ... }:
{
  flake.homeModules.hmJon =
    { pkgs, ... }:
    {
      imports = [ inputs.jon.homeManagerModules.default ];

      programs.jon = {
        enable = true;
        # On jon's PATH only, after the devShell's: the language servers and the tools they run.
        extraPackages = with pkgs; [
          # Nix: nixd formats with nixfmt.
          nixd
          nixfmt
          # Rust: rust-analyzer takes cargo, clippy and rustfmt from the project's devShell.
          rust-analyzer
          # C and C++: clice lints with clang-tidy and formats with clang-format on its own.
          self.packages.${pkgs.stdenv.hostPlatform.system}.clice
        ];
      };
    };
}
