{
  pkgs,
  inputs,
  ...
}:
let
  pluginsDir = ../plugins;
  sourceLuaFile =
    file:
    let
      path = pluginsDir + "/${file}";
    in
    ''
      lua <<'EOF'
      ${builtins.readFile path}
      EOF
    '';
in
{
  imports = [
    (import ./coding.nix { inherit pkgs sourceLuaFile; })
    (import ./editor.nix { inherit pkgs sourceLuaFile; })
    (import ./lsp.nix { inherit pkgs sourceLuaFile; })
    (import ./ui.nix { inherit pkgs sourceLuaFile; })
    (import ./themes.nix { inherit pkgs sourceLuaFile; })
    (import ./utils.nix { inherit pkgs sourceLuaFile; })
  ];
}
