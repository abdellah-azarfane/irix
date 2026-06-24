{ ... }:
{
  flake.nixosModules.lang-systems =
    { pkgs, config, ... }:
    {
      home-manager.users.${config.preferences.user.name} = {
        home.packages = with pkgs; [
          # --- C / C++ / Build Systems ---
          clang-tools # Includes clang-format
          gcc # GNU compiler collection
          cmake-language-server
          cmake-format
          gnumake # Make files
          gnutls # GNU transport layer security library
          pkg-config # Package information finder



          # --- Rust ---
          rustup # Rust toolchain
          bacon # Rust build tool
          cargo-info # Cargo package manager
          rusty-man # Rust tr

          # --- Go ---
          go
          goimports-reviser
          gopls
          gofumpt
          gomodifytags
          gotests
          gore
          prettier-plugin-go-template

          # --- JVM & Enterprise (Java, Kotlin, C#, Scala) ---
          google-java-format
          jdt-language-server
          kotlin-language-server
          omnisharp-roslyn # C# / .NET / F#
          fsautocomplete # F#
          metals # Scala
          scalafmt # Scala formatter

          # --- Systems & Others (Zig, Swift, Crystal, Fortran, GLSL) ---
          zig
          zls
          sourcekit-lsp # Swift
          crystal
          icr
          fortls # Fortran
          fprettify # Fortran
          glslls # GLSL
          buf # Protocol Buffers
        ];
      };
    };
}
