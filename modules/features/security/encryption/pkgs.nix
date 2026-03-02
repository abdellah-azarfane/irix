{
  flake.modules.homeManager.security =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # --- openssl ---
        openssl
        # --- Pass & Gnupg ---
        # Required by Proton Bridge
        pass
        gnupg
        age
        sops
      ];
    };
}
