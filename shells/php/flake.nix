{
  description = "Symfony PHP development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs}:
    let
    system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };

  php = pkgs.php.withExtensions ({ enabled, all }: with all; [
      xsl
      zlib
      tokenizer
      filter
      openssl
      iconv
      session
  ]);

  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        php
          pkgs.phpPackages.composer
          pkgs.symfony-cli
      ];


      shellHook = ''
        zsh
        export PHP_MEMORY_LIMIT=-1
        echo "PHP development shell ready"
        php -v
        '';
    };
  };
}
