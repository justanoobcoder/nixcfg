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
      url = "github:justanoobcoder/fcitx5-lotus/ecm";
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

    keypop = {
      url = "github:justanoobcoder/keypop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    hyprland.url = "github:hyprwm/Hyprland";

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    HyprQuickFrame = {
      url = "github:Ronin-CK/HyprQuickFrame";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      inputs.import-tree.filterNot (path: baseNameOf path == "secrets.nix") ./modules
    );
}
