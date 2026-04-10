{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        }; 
        grub2-themes = {
            url = "github:vinceliuice/grub2-themes";
        };
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        chaotic = {
          url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        ags = {
          url = "github:aylur/ags";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        astal = {
          url = "github:aylur/astal";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, chaotic, ... }@inputs:
      let
        commonModules = [
          ./modules/nixos/nixbase.nix
          ./modules/nixos/desktop-environment.nix
          ./modules/nixos/developement-tools.nix
          inputs.grub2-themes.nixosModules.default
        ];
      in
        {
            nixosConfigurations = {
              main = nixpkgs.lib.nixosSystem {
                  specialArgs = {inherit inputs;};
                  modules = commonModules ++ [
                      ./hosts/main/configuration.nix
                      ./modules/nixos/nvidia.nix
                      inputs.chaotic.nixosModules.default
                      inputs.home-manager.nixosModules.home-manager
                      {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.ben = import ./hosts/main/home.nix;
                      }
                  ];
              };
              laptop = nixpkgs.lib.nixosSystem {
                  specialArgs = {inherit inputs;};
                  modules = commonModules ++ [
                      ./hosts/laptop/configuration.nix
                      inputs.home-manager.nixosModules.home-manager
                      {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.ben = import ./hosts/laptop/home.nix;
                      }
                  ];
              };
            };
        };
}
