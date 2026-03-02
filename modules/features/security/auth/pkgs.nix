{
  flake.modules.homeManager.security =
    { pkgs, ... }:
    {
      home.packages = [

        # --- Bitwarden ---
        pkgs.bitwarden-desktop
        pkgs.bitwarden-cli

        # --- Protonpass ---
        # pkgs.proton-pass
      ];
    };
}
