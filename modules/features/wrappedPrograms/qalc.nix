{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.qalc = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = pkgs.libqalculate;
      flags = {
        "-s" = [
          "autocalc"
          "decimal comma off"
        ];
      };
    };
  };
}
