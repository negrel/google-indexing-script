{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ nodejs_18 ];
          };
        };
        packages = {
          default = pkgs.buildNpmPackage {
            pname = "gis";
            version = "0.4.0";

            src = ./.;

            npmDepsHash = "sha256-joOSbzqtAJJ8MNWU93hm2qHPM/p4vzj+cdEJ1c7IOeE=";

            meta = {
              description = "Script to get your site indexed on Google in less than 48 hours.";
              homepage = "https://github.com/goenning/google-indexing-script";
              license = lib.licenses.mit;
            };
          };
        };
      }
    );
}

