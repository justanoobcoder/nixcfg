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

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

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

    wayshadow = {
      url = "github:justanoobcoder/wayshadow";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-jot = {
      url = "path:/home/hiepnh/Projects/rust/fcitx5-jot";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jotty = {
      url = "path:/home/hiepnh/Projects/jotty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    umbriel.url = "github:noctalia-dev/umbriel/cachix";

    pleamar = {
      url = "path:/home/hiepnh/Projects/experiments/pleamar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
