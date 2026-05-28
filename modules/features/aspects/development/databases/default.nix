{
  flake.nixosModules.databases =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # --- Databases ---
        redis
        postgresql
        dbeaver-bin

        # --- TUI Clients ---
        rainfrog # Database management TUI for Postgres, MySQL, SQLite
        harlequin # Modern SQL IDE for terminal
        # gobang # Cross-platform database management TUI
        lazysql # Database management TUI in Go
      ];
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_17;
        extensions = with pkgs.postgresql_17.pkgs; [ pgvector ];
      };
    };
}
