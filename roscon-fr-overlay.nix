final: prev: {
  rosPackages = prev.rosPackages // {
    jazzy = prev.rosPackages.jazzy.overrideScope (
      jazzy-final: jazzy-prev: {
        plotjuggler = jazzy-prev.plotjuggler.overrideAttrs (super: rec {
          version = "3.10.11";
          src = final.fetchFromGitHub {
            owner = "facontidavide";
            repo = "PlotJuggler";
            tag = version;
            hash = "sha256-BFY4MpJHsGi3IjK9hX23YD45GxTJWcSHm/qXeQBy9u8=";
          };
          postPatch = ''
            (
              echo "function(find_or_download_data_tamer)"
              echo "  find_package(data_tamer_cpp REQUIRED)"
              echo "  add_library(data_tamer::parser ALIAS data_tamer_cpp::data_tamer)"
              echo "  add_library(data_tamer_parser ALIAS data_tamer_cpp::data_tamer)"
              echo "endfunction()"
            ) > cmake/find_or_download_data_tamer.cmake
          '';
          buildInputs = [
            final.libbfd
            final.lua
            final.nlohmann_json
            final.lz4
            jazzy-prev.data-tamer-cpp
            jazzy-prev.mcap-vendor
          ] ++ (super.buildInputs or [ ]);
        });
        plotjuggler-ros = jazzy-prev.plotjuggler-ros.overrideAttrs (rec {
          version = "2.3.1";
          src = final.fetchFromGitHub {
            owner = "PlotJuggler";
            repo = "plotjuggler-ros-plugins";
            tag = version;
            hash = "sha256-5AR6UbRAE42NZwFR5G+ECdeuvNC3u4UXvIPr8OPZkjQ=";
          };
        });
        ros2-control-demo-example-1 = jazzy-prev.ros2-control-demo-example-1.overrideAttrs (super: {
          propagatedBuildInputs = (super.propagatedBuildInputs or [ ]) ++ [ jazzy-final.ros2-control-cmake ];
          doCheck = false;
        });
      }
    );
  };
}
