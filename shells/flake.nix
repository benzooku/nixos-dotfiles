{
    description = "Elixir Shell";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs }: 
        let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in 
            { 
            devShells.x86_64-linux.default = pkgs.mkShell {

                packages = [
                    pkgs.beam27Packages.elixir
                    pkgs.beam27Packages.hex
                    pkgs.beam27Packages.erlang
                    pkgs.beam27Packages.elixir-ls
                ];

                    
                shellHook = ''
                zsh
                '';

            };


        };
}
