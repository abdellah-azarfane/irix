{
  config,
  pkgs,
  irixLib,
  userPreferences,
  ...
}:
{
  home.file."${config.xdg.dataHome}/rhodium-utils/metadata.json".source =
    pkgs.writeText "rhodium-utils-metadata.json" (
      builtins.toJSON (irixLib.generators.utilsMetadataGenerators userPreferences.metadata)
    );
}
