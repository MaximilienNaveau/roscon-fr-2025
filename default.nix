{
  lib,

  # nativeBuildInputs
  fmt,
  buildRosPackage,

  # propagatedBuildInputs
  python3Packages,
  std-msgs,
  rclpy,
  launch,
  launch-ros,
  plotjuggler,
  plotjuggler-ros,
  ros2-control-demo-example-1,

  # checkInputs
  ament-copyright,
  ament-flake8,
  ament-pep257
}:
buildRosPackage {
  pname = "pal_stats_demo";
  version = "0-unstable-2025-08-29";

  src = ./pal_stats_demo;

  buildType = "ament_python";
  checkInputs = [
    ament-copyright
    ament-flake8
    ament-pep257
    python3Packages.pytest
  ];
  nativeBuildInputs = [
    fmt
  ];
  propagatedBuildInputs = [
    std-msgs
    rclpy
    launch
    launch-ros
    plotjuggler
    plotjuggler-ros
    ros2-control-demo-example-1
  ];

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
}
