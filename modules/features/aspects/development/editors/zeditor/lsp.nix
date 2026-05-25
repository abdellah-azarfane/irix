{
  flake.nixosModules.zedlsp = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.zed-editor = {
        userSettings = {
          lsp = {
            rust-analyzer = {
              binary = {
                path = lib.getExe pkgs.rust-analyzer;
                path_lookup = true;
              };
            };

            nix = {
              binary = {
                path_lookup = true;
              };
            };

            nil = {
              binary.path = "nil";
              binary.arguments = [ ];
            };

            elixir-ls = {
              binary = {
                path_lookup = true;
              };
              settings = {
                dialyzerEnabled = true;
              };
            };
          };
        };
      };
    };
  };
}
