{
  description = "Abstract and demo for the roscon-fr-2025";

  inputs = {
    gepetto.url = "github:gepetto/nix";
    flake-parts.follows = "gepetto/flake-parts";
    gazebo-sim-overlay.follows = "gepetto/gazebo-sim-overlay";
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
      perSystem =
        {
          lib,
          pkgs,
          self',
          ...
        }:
        {
          packages = {
            default = self'.packages.roscon-fr-demo;
            roscon-fr-demo = with pkgs.rosPackages.humble; buildEnv {
               name = "roscon-fr-demo";
               paths = [
                 self'.packages.pal-stats-demo
                #  self'.packages.roscon-fr-2025-abstract
               ];
            };
            pal-stats-demo = python3Packages.buildPythonPackage{
                pname = "pal-stats-demo";
                version = "0-unstable-2025-08-29";

                src = ./pal_stats_demo;
                sourceRoot = "source/pal_stats_demo";

                dontUseCmakeConfigure = true;
                dontUseCmakeBuild = true;
                dontUseCmakeCheck = true;
                dontUseCmakeInstall = true;

                nativeBuildInputs = [
                  fmt
                ];

                propagatedBuildInputs = [
                  pkgs.python3Packages.python
                  pkgs.rosPackages.jazzy.std-msgs
                  pkgs.rosPackages.jazzy.rclpy
                  pkgs.rosPackages.jazzy.pal-statistics
                  pkgs.rosPackages.jazzy.launch
                  pkgs.rosPackages.jazzy.launch-ros
                  pkgs.rosPackages.jazzy.plotjuggler
                  pkgs.rosPackages.jazzy.ros2-control-demo-example-1
                ];

                doCheck = true;
                pythonImportsCheck = [ "pal_stats_demo" ];

                meta = {
                  description = "Demo package for pal_statistics introspection.";
                  homepage = "https://github.com/MaximilienNaveau/roscon-fr-2025";
                  license = lib.licenses.bsd3;
                  maintainers = [ "MaximilienNaveau" ];
                  platforms = lib.platforms.linux;
                };
              }
            };
            # roscon-fr-2025-abstract = …;
          }
        };
    };
}
