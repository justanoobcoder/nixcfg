{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noobvim = {
      url = "path:/home/hiepnh/proj/noobvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-lotus = {
      url = "path:/home/hiepnh/proj/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jcm = {
      url = "path:/home/hiepnh/proj/jcm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    wayvibes = {
      url = "path:/home/hiepnh/proj/wayvibes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        (inputs.import-tree ./modules)
      ];

      flake.nixosModules.globalOverlays = {
        nixpkgs.overlays = [
          (import ./pkgs)
          (import ./overlays)
        ];
      };
    };
}
