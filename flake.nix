{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix = {
          url = "github:nix-community/stylix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        grub2-themes = {
            url = "github:vinceliuice/grub2-themes";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs:
        {
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [
                    inputs.stylix.nixosModules.stylix
                    ./hosts/main/configuration.nix
                    inputs.home-manager.nixosModules.default
                    ./modules/nixos/desktop-environment.nix
                    ./modules/nixos/developement-tools.nix
                    inputs.grub2-themes.nixosModules.default
                    ./modules/nixos/nvidia.nix
                ];
            };
        };
}
