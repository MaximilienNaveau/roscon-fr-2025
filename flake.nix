{
  description = "Abstract and demo for the roscon-fr-2025";

  inputs = {
    gepetto.url = "github:nim65s/gepetto-nix/maxboost";
    flake-parts.follows = "gepetto/flake-parts";
    nixpkgs.follows = "gepetto/nixpkgs";
    nix-ros-overlay.follows = "gepetto/nix-ros-overlay";
    systems.follows = "gepetto/systems";
    treefmt-nix.follows = "gepetto/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.gepetto.flakeModule ];
      gepetto-pkgs.overlays = [ (import ./roscon-fr-overlay.nix) ];
      perSystem =
        {
          pkgs,
          self',
          ...
        }:
        {
          devShells = {
            default = pkgs.mkShell {
              name = "roscon-fr-dev-shell";
              packages = [
                self'.packages.default
              ];
            };
            latex = pkgs.mkShell {
              name = "roscon-fr-latex-shell";
              packages = [
                pkgs.poppler_utils # provides pdftotext, pdfimages
                pkgs.texlive.combined.scheme-full
                pkgs.bash
              ];
            };
          };
          packages = {
            default = self'.packages.roscon-fr-demo;
            roscon-fr-demo =
              with pkgs.rosPackages.jazzy;
              buildEnv {
                name = "roscon-fr-demo";
                paths = [
                  self'.packages.pal-stats-demo
                ];
              };
            pal-stats-demo = pkgs.rosPackages.jazzy.callPackage ./pal_stats_demo/default.nix { };

            inherit (pkgs.rosPackages.jazzy) mcap-vendor;
          };
        };
    };
}
