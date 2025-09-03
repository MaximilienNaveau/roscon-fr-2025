{
  lib,

  # nativeBuildInputs
  fmt,

  # propagatedBuildInputs
  python3Packages,
  std-msgs,
  rclpy,
  launch,
  launch-ros,
  plotjuggler,
  plotjuggler-ros,
  ros2-control-demo-example-1,

}:
python3Packages.buildPythonPackage {
  pname = "pal-stats-demo";
  version = "0-unstable-2025-08-29";

  src = ./pal_stats_demo;
  sourceRoot = "./pal_stats_demo";

  dontUseCmakeConfigure = true;
  dontUseCmakeBuild = true;
  dontUseCmakeCheck = true;
  dontUseCmakeInstall = true;

  nativeBuildInputs = [
    fmt
  ];

  propagatedBuildInputs = [
    python3Packages.python

    std-msgs
    rclpy
    launch
    launch-ros
    plotjuggler
    plotjuggler-ros
    ros2-control-demo-example-1

  ];

  doCheck = true;
  dontWrapQtApps = true;
  pythonImportsCheck = [ "pal_stats_demo" ];
  format = "other";

  buildPhase = ''
    runHook preBuild

    python setup.py build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/${python3Packages.python.sitePackages}"
    export PYTHONPATH="$out/${python3Packages.python.sitePackages}:$PYTHONPATH"
    python setup.py install --prefix="$out" --single-version-externally-managed --record /dev/null

    runHook postInstall
  '';

  postFixup = ''
    find "$out/lib" -mindepth 1 -maxdepth 1 -type d ! -name '${python3Packages.python.libPrefix}' -print0 | while read -d "" libpkgdir; do
      wrapPythonProgramsIn "$libpkgdir" "$out $pythonPath"
    done
  '';

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
