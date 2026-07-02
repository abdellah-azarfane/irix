{ ... }:
{
  flake.nixosModules.lang-systems = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- C / C++ / Build Systems ---
        clang-tools # Includes clang-format
        gcc # GNU compiler collection
        gnumake # Make files
        pkg-config # Package information finder
        cmake-language-server

        # --- Rust ---
        rustup # Rust toolchain
        bacon # Rust background build tool

        # --- Go (Lean API support) ---
        go
        gopls
      ];
    };
  };
}
