{ ... }:
{
  flake.nixosModules.lang-systems = { pkgs, config, ... }: {
    home-manager.users.${config.preferences.user.name} = {
      home.packages = with pkgs; [
        # --- C / C++ / Build Systems ---
        clang-tools # Includes clang-format
        gcc # GNU compiler collection
        gnumake # Make files
        cmake # Cross-platform build system
        pkg-config # Package information finder
        cmake-language-server
        libxml2   # Provides xmllint for formatting XML/data

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
