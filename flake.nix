{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noobvim = {
      url = "github:justanoobcoder/noobvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zalo = {
      url = "github:justanoobcoder/zalo-for-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fcitx5-vmk.url = "path:/home/hiepnh/proj/VMK";
    # fcitx5-vmk = {
    #   url = "github:nhktmdzhg/VMK";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    custom-pkgs = final: prev: {
      custom = import ./pkgs {pkgs = prev;};
    };
  in {
    packages = forAllSystems (system: import ./pkgs {pkgs = nixpkgs.legacyPackages.${system};});

    overlays =
      (import ./overlays {inherit inputs;})
      // {
        default = custom-pkgs;
      };

    nixosConfigurations.nixos-pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos-pc
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays =
            [
              self.overlays.default
            ]
            ++ (builtins.attrValues (import ./overlays {inherit inputs;}));

          home-manager = {
            users.hiepnh = ./home/hiepnh;
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs;};
          };
        }
      ];
    };
  };
}
