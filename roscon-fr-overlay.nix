final: prev: {
  rosPackages = prev.rosPackages // {
    jazzy = prev.rosPackages.jazzy.overrideScope (
      jazzy-final: jazzy-prev: {
        ros2-control-demo-example-1 = jazzy-prev.ros2-control-demo-example-1.overrideAttrs (super: {
          propagatedBuildInputs = (super.propagatedBuildInputs or [ ]) ++ [ jazzy-final.ros2-control-cmake ];
          doCheck = false;
        });
      }
    );
  };
}
