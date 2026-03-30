{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.quickshellWrapped = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = pkgs.quickshell;
      extraPackages = [
        pkgs.zoxide
      ];
      flags = {
        "-c" = toString ./.;
      };
    };
  };
}
