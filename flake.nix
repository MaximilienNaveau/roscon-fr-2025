{
  description = "Abstract and demo for the roscon-fr-2025";

  inputs = {
    gepetto.url = "github:nim65s/gepetto-nix/maxboost";
    flake-parts.follows = "gepetto/flake-parts";
    # gazebo-sim-overlay.follows = "gepetto/gazebo-sim-overlay";
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
          };
          packages = {
            default = self'.packages.roscon-fr-demo;
            roscon-fr-demo =
              with pkgs.rosPackages.jazzy;
              buildEnv {
                name = "roscon-fr-demo";
                paths = [
                  self'.packages.pal-stats-demo
                  #  self'.packages.roscon-fr-2025-abstract
                ];
              };
            pal-stats-demo = pkgs.rosPackages.jazzy.callPackage ./default.nix { };
          };
        };
    };
}
