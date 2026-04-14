{
  config,
  lib,
  ...
}: {
  perSystem = { pkgs, ... }: {
    
    devShells.quickshell-dev = pkgs.mkShell {
      name = "quickshell-dev";
      
      # Tools required ONLY when working on your shell
      buildInputs = with pkgs; [
        quickshell
        qt6.qtdeclarative # Provides qml tools
        qmlls             # QML Language Server for your editor
        python3
        nodejs
      ];

      # Optional: Set environment variables specific to this shell
      # QML_SCENE_DEVICE = "softwarecontext"; # Uncomment if you get Wayland GPU rendering errors

      shellHook = ''
        echo "🚀 Quickshell Dev Environment Loaded"
        echo "Use 'qs -c shell.qml' to preview your work."
      '';
    };

  };
}
