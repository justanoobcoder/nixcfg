{inputs, ...}:
{
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    fastfetch = import ./mods/fastfetch.nix {inherit prev;};
    #amber-lang = import ./mods/amber-lang.nix {inherit prev;};
    #vicinae = import ./mods/vicinae.nix {inherit prev;};
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
