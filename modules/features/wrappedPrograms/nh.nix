{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.nh = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = pkgs.nh;
      env = {
        "NH_FLAKE" = "/home/abosafiya/dev/irix";
      };
    };
  };
}
