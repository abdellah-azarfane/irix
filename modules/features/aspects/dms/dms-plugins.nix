{
  flake.nixosModules.dms-plugins =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    let
      user = config.preferences.user.name;
      sys = pkgs.stdenv.hostPlatform.system;

      # Create the script directly in the Nix store
      dms-wall-script = pkgs.writeShellScript "dms-wall" ''
        HOOK_NAME="$1"
        HOOK_VALUE="$3"

        # Log every trigger to a file so we can debug it
        echo "$(date): Hook triggered. NAME=$HOOK_NAME | VALUE=$HOOK_VALUE" >> /tmp/dms-hook.log

        if [ "$HOOK_NAME" = "onWallpaperChanged" ]; then
            echo "$(date): Executing wallust on $HOOK_VALUE" >> /tmp/dms-hook.log

            # Run wallust and capture any potential errors
            ${pkgs.wallust}/bin/wallust run "$HOOK_VALUE" >> /tmp/dms-hook.log 2>&1

            echo "$(date): Wallust finished" >> /tmp/dms-hook.log
        fi
      '';
    in
    {
      home-manager.users.${user} = {
        programs.dank-material-shell = {
          managePluginSettings = true;
          plugins = {
            dankHooks = {
              enable = true;
              src = inputs.dms-plugin-registry.packages.${sys}.dankHooks;
              settings = {
                # Inject the absolute Nix store path directly
                scriptPath = "${dms-wall-script}";
              };
            };
          };
        };
      };
    };
}
