{
  description = "Abstract and demo for the roscon-fr-2025";

  inputs = {
    gepetto.url = "github:nim65s/gepetto-nix/max";
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
      perSystem =
        {
          lib,
          pkgs,
          self',
          ...
        }:
        {
          devShells = {
            default = pkgs.mkShell {
              name = "roscon-fr-dev-shell";
              packages = [
                self'.packages.roscon-fr-demo
                pkgs.libGL
                pkgs.libGLU
              ];
            };
          };
          packages = {
            default = self'.packages.roscon-fr-demo;
            roscon-fr-demo = with pkgs.rosPackages.humble; buildEnv {
               name = "roscon-fr-demo";
               paths = [
                self'.packages.pal-stats-demo
                #  self'.packages.roscon-fr-2025-abstract
               ];
            };
            pal-stats-demo = pkgs.python3Packages.buildPythonPackage {
              pname = "pal-stats-demo";
              version = "0-unstable-2025-08-29";

              src = ./pal_stats_demo;

              dontUseCmakeConfigure = true;
              dontUseCmakeBuild = true;
              dontUseCmakeCheck = true;
              dontUseCmakeInstall = true;

              nativeBuildInputs = [
                pkgs.fmt
              ];

              propagatedBuildInputs = [
                pkgs.python3Packages.python
                pkgs.rosPackages.jazzy.std-msgs
                pkgs.rosPackages.jazzy.rclpy
                pkgs.rosPackages.jazzy.pal-statistics
                pkgs.rosPackages.jazzy.launch
                pkgs.rosPackages.jazzy.launch-ros
                self'.packages.ros-jazzy-plotjuggler
                self'.packages.ros-jazzy-plotjuggler-ros
                self'.packages.ros-jazzy-ros2-control-demo-example-1
              ];

              doCheck = true;
              dontWrapQtApps = true;
              pythonImportsCheck = [ "pal_stats_demo" ];

              meta = {
                description = "Demo package for pal_statistics introspection.";
                homepage = "https://github.com/MaximilienNaveau/roscon-fr-2025";
                license = lib.licenses.bsd2;
                maintainers = [
                  {
                    name = "Maximilien Naveau";
                    github = "MaximilienNaveau";
                    githubId = 5736679;
                  }
                ];
                platforms = lib.platforms.linux;
              };
            };
            ros-jazzy-ros2-control-demo-example-1 = pkgs.rosPackages.jazzy.ros2-control-demo-example-1.overrideAttrs {
              nativeBuildInputs = [
                pkgs.rosPackages.jazzy.ament-cmake
                pkgs.rosPackages.jazzy.ros2-control-cmake
              ] ++ (pkgs.ros-jazzy-ros2-control-demo-example-1.nativeBuildInputs or []);
              propagatedBuildInputs = [
                pkgs.rosPackages.jazzy.launch-testing-ros
                pkgs.rosPackages.jazzy.controller-manager
                pkgs.rosPackages.jazzy.launch
                pkgs.rosPackages.jazzy.launch-ros
                pkgs.rosPackages.jazzy.ros2launch
                pkgs.rosPackages.jazzy.xacro
                pkgs.rosPackages.jazzy.ros2-control-demo-description
                pkgs.rosPackages.jazzy.joint-state-broadcaster
                pkgs.rosPackages.jazzy.forward-command-controller
                pkgs.rosPackages.jazzy.robot-state-publisher
                pkgs.rosPackages.jazzy.ros2-controllers-test-nodes
              ] ++ (pkgs.ros-jazzy-ros2-control-demo-example-1.propagatedBuildInputs or []);
              doCheck = false;
            };
            ros-jazzy-plotjuggler = pkgs.rosPackages.jazzy.plotjuggler.overrideAttrs {
              src = pkgs.fetchFromGitHub {
                owner = "facontidavide";
                repo = "PlotJuggler";
                rev = "3.10.11";
                sha256 = "sha256-BFY4MpJHsGi3IjK9hX23YD45GxTJWcSHm/qXeQBy9u8=";
              };
            };
            ros-jazzy-plotjuggler-ros = pkgs.rosPackages.jazzy.plotjuggler-ros.overrideAttrs {
              src = pkgs.fetchFromGitHub {
                owner = "PlotJuggler";
                repo = "plotjuggler-ros-plugins";
                rev = "2.3.1";
                sha256 = "sha256-5AR6UbRAE42NZwFR5G+ECdeuvNC3u4UXvIPr8OPZkjQ=";
              };
            };
          };
        };
    };
}
