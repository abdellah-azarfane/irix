{
  flake.nixosModules.zedlangs =
    {
      pkgs,
      config,
      inputs,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      home-manager.users.${user} = {
        programs.zed-editor = {
          userSettings = {
            languages = {
              Python = {
                tab_size = 4;
                formatter = "language_server";
                format_on_save = "on";
              };

              Lua = {
                tab_size = 2;
                formatter = "language_server";
                format_on_save = "on";
              };

              Nix = {
                language_servers = [ "nil" ];
                format_on_save = "on";
                formatter = {
                  external = {
                    command = "nixpkgs-fmt";
                    arguments = [ ];
                  };
                };
              };

              "Elixir" = {
                language_servers = [
                  "!lexical"
                  "elixir-ls"
                  "!next-ls"
                ];
                format_on_save = "on";
                formatter = {
                  external = {
                    command = "mix";
                    arguments = [
                      "format"
                      "--stdin-filename"
                      "{buffer_path}"
                      "-"
                    ];
                  };
                };
              };

              "HEEX" = {
                language_servers = [
                  "!lexical"
                  "elixir-ls"
                  "!next-ls"
                ];
                format_on_save = "on";
                formatter = {
                  external = {
                    command = "mix";
                    arguments = [
                      "format"
                      "--stdin-filename"
                      "{buffer_path}"
                      "-"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
}
