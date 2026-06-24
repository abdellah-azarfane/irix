{
  flake.nixosModules.emacs =
    {
      pkgs,
      config,
      inputs,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {

      home-manager.users.${user} = {
        imports = [
          inputs.my-emacs.homeManagerModules.default
        ];
      };
    };
}
