{
  description = "Haskell development environment for HIPY";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        haskellEnv = pkgs.haskellPackages.ghcWithPackages (_: []);

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            haskellEnv
            python3
            cabal-install
            git
          ];

          shellHook = ''
            export PS1="(hipy) $PS1"
          '';

          PROJECT_NAME = "hipy";
        };
      });
}
