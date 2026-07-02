{
  flake.nixosModules.databases =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # --- TUI Clients ---
        rainfrog # Database management TUI for Postgres, MySQL, SQLite
      ];
    };
}
