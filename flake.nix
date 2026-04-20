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

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    noobvim = {
      url = "github:justanoobcoder/noobvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-lotus = {
      url = "github:LotusInputMethod/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jcm = {
      url = "github:justanoobcoder/jcm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayvibes = {
      url = "github:justanoobcoder/wayvibes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree.filterNot (path: baseNameOf path == "secrets.nix") ./modules);
}
