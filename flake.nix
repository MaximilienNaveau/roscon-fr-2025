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
            pal-stats-demo = pkgs.python3Packages.buildPythonPackage {
              pname = "pal-stats-demo";
              version = "0-unstable-2025-08-29";

              src = ./pal_stats_demo;
              sourceRoot = "source/pal_stats_demo";

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
                pkgs.rosPackages.jazzy.plotjuggler
                self'.packages.ros2-control-demo-example-1
              ];

              doCheck = true;
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
            ros2-control-demo-example-1 = pkgs.python3Packages.buildPythonPackage {
              pname = "ros2-control-demo-example-1";
              version = "0-unstable-2025-08-29";

              src = pkgs.fetchFromGitHub {
                owner = "ros-controls";
                repo = "ros2_control_demos";
                tag = "a7ae85f8f2a273bb239e8de7349969386f4028de";
                hash = lib.fakeSha256;
              };
              nativeBuildInputs = [
                pkgs.rosPackages.jazzy.ament-cmake
                pkgs.rosPackages.jazzy.ros2-control-cmake
              ];

              propagatedBuildInputs = with pkgs.rosPackages.jazzy; [
                # Depend
                backward-ros
                hardware-interface
                pluginlib
                rclcpp
                rclcpp-lifecycle
                # Exec depend
                controller-manager
                forward-command-controller
                joint-state-broadcaster
                joint-state-publisher-gui
                joint-trajectory-controller
                robot-state-publisher
                ros2-controllers-test-nodes
                ros2controlcli
                ros2launch
                rqt-joint-trajectory-controller
                rviz2
                xacro
                # self depend
                self'.packages.ros2-control-demo-description
              ];

              testInputs = with pkgs.rosPackages.jazzy; [
                ament-cmake-pytest
                launch-testing
                launch
                liburdfdom-tools
                rclpy
              ];

              doCheck = true;

              meta = {
                description = "Demo package of `ros2_control` hardware for RRbot.";
                homepage = "https://github.com/ros-controls/ros2_control_demos";
                license = lib.licenses.asl20;
                maintainers = [
                  {
                    name = "Dr.-Ing. Denis Štogl";
                    github = "destogl";
                    githubId = 1918204;
                  }
                ];
                platforms = lib.platforms.linux;
              };
            };
            ros2-control-demo-description = pkgs.python3Packages.buildPythonPackage {
              pname = "ros2-control-demo-description";
              version = "0-unstable-2025-08-29";

              src = pkgs.fetchFromGitHub {
                owner = "ros-controls";
                repo = "ros2_control_demos";
                tag = "a7ae85f8f2a273bb239e8de7349969386f4028de";
                hash = lib.fakeSha256;
              };
              nativeBuildInputs = [
                pkgs.rosPackages.jazzy.ament-cmake
              ];

              propagatedBuildInputs = with pkgs.rosPackages.jazzy; [
                rviz2
              ];

              doCheck = true;

              meta = {
                description = "Description package for the ros2_control demo robots.";
                homepage = "https://github.com/ros-controls/ros2_control_demos";
                license = lib.licenses.asl20;
                maintainers = [
                  {
                    name = "Dr.-Ing. Denis Štogl";
                    github = "destogl";
                    githubId = 1918204;
                  }
                ];
                platforms = lib.platforms.linux;
              };
            };

          };
        };
    };
}
