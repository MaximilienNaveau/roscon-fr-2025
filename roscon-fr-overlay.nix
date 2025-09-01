self: super: {
  rosPackages = super.rosPackages // {
    jazzy = super.rosPackages.jazzy // {
      plotjuggler = super.rosPackages.jazzy.plotjuggler.overrideAttrs (old: {
        name = "ros-jazzy-plotjuggler-3.10.11";
          src = pkgs.fetchFromGitHub {
            owner = "facontidavide";
            repo = "PlotJuggler";
            rev = "3.10.11";
            sha256 = "sha256-BFY4MpJHsGi3IjK9hX23YD45GxTJWcSHm/qXeQBy9u8=";
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
          BuildInputs = [
            pkgs.libbfd
            pkgs.lua
            pkgs.nlohmann_json
            pkgs.lz4
            pkgs.rosPackages.jazzy.data-tamer-cpp
            pkgs.rosPackages.jazzy.mcap-vendor
          ] ++ (old.BuildInputs or []);
          propagatedBuildInputs = [
            pkgs.libbfd
            pkgs.lua
            pkgs.nlohmann_json
            pkgs.lz4
            pkgs.rosPackages.jazzy.data-tamer-cpp
            pkgs.rosPackages.jazzy.mcap-vendor
          ] ++ (old.propagatedBuildInputs or []);
      });
      ros-jazzy-plotjuggler-ros = pkgs.rosPackages.jazzy.plotjuggler-ros.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "PlotJuggler";
          repo = "plotjuggler-ros-plugins";
          rev = "2.3.1";
          sha256 = "sha256-5AR6UbRAE42NZwFR5G+ECdeuvNC3u4UXvIPr8OPZkjQ=";
        };
        buildInputs = [
          self'.packages.ros-jazzy-plotjuggler
        ];
      };
    };
  };
}
