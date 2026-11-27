{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    noobvim = {
      url = "github:justanoobcoder/noobvim/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-lotus = {
      url = "github:LotusInputMethod/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-craftapps = {
      url = "github:olafkfreund/nix-craftapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zalo-for-linux = {
      url = "github:VN-Linux-Family/zalo-for-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
    # Private repos, fetched over SSH. The cachix branch only points at commits whose builds are in
    # justanoobcoder.cachix.org. To build a local checkout: --override-input unda ~/Projects/unda
    keywave.url = "git+ssh://git@github.com/justanoobcoder/keywave?ref=cachix";
    fcitx5-jot.url = "git+ssh://git@github.com/justanoobcoder/fcitx5-jot?ref=cachix";
    unda.url = "git+file:/home/hiepnh/Projects/unda";
    # jon has no cachix branch, so it builds locally.
    jon.url = "git+file:/home/hiepnh/Projects/jon";
    # Public; a github: tarball honours export-ignore, so its hash is stable across Nix versions.
    jotty.url = "github:justanoobcoder/jotty/cachix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
