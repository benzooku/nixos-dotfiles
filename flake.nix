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
    };

    outputs = { self, nixpkgs, ... }@inputs:
      let
        commonModules = [
          ./modules/nixos/nixbase.nix
          inputs.home-manager.nixosModules.default
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
                  ];
              };
              laptop = nixpkgs.lib.nixosSystem {
                  specialArgs = {inherit inputs;};
                  modules = commonModules ++ [
                      ./hosts/laptop/configuration.nix
                  ];
              };
            };
        };
}
