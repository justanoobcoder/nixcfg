{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    wayscriber.url = "github:devmobasa/wayscriber";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
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

    jcm.url = "path:/home/hiepnh/proj/jcm";
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
