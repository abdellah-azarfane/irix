{inputs, ...}: {
  perSystem = {pkgs, inputs, ...}: {
    packages.quickshellWrapped = pkgs.stdenv.mkDerivation {
      pname = "quickshell-config";
      version = "1.0.0";
      dontUnpack = true;

      nativeBuildInputs = [
        pkgs.makeWrapper
        pkgs.kdePackages.wrapQtAppsHook 
      ];

      buildInputs = with pkgs.kdePackages; [
        qtbase
        qtdeclarative
        qtsvg
        qtwayland
        qt5compat
        inputs.qml-niri.packages.${pkgs.system}.default
      ];

      installPhase = ''
        mkdir -p $out/bin
        
        makeWrapper ${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell $out/bin/quickshell \
          "''${qtWrapperArgs[@]}" \
          --add-flags "-c ${toString ./.}"
      '';
    };
  };
}