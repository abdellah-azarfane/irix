{
  inputs,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: let
    # defaultRevset = "present(@) | ancestors(immutable_heads()) | present(trunk())";
    defaultRevset = "all()";
  in {
    packages.jjui =
      (self.lib.wrapperModules.jjui.apply {
        inherit pkgs;
        settings = {
          preview = {
            show_at_start = true;
          };
        };
        flags = {
          "-r" = defaultRevset;
        };
      }).wrapper;

    packages.jujutsu = let
      logCommand = ["log" "--reversed" "--no-pager" "-r" defaultRevset "-n" "20"];
    in
      (inputs."wrapper-modules".wrappers.jujutsu.apply {
        inherit pkgs;
        settings = {
          user = {
            name = "Yurii";
            email = "yurii@goxore.com";
          };
          aliases = {
            l = logCommand;
          };
          ui = {
            default-command = logCommand;
          };
          snapshot = {
            max-new-file-size = "15MiB";
          };
        };
      }).wrapper;
  };

  flake.lib.wrapperModules.jjui = inputs."wrapper-modules".lib.wrapModule (
    {
      config,
      pkgs,
      lib,
      ...
    }: let
      tomlFormat = pkgs.formats.toml {};
    in {
      options = {
        settings = lib.mkOption {
          type = tomlFormat.type;
        };
      };

      config = {
        package = pkgs.jjui;

        env = {
          JJUI_CONFIG_DIR = let
            generatedFile = tomlFormat.generate "config.toml" config.settings;

            configDir = pkgs.runCommand "jjui-config-dir" {} ''
              mkdir -p $out
              cp ${generatedFile} $out/config.toml
            '';
          in "${configDir}";
        };
      };
    }
  );
}
