{
  flake.nixosModules.emacs = { pkgs, config, ... }:
  let
     user = config.preferences.user.name;
  in {
     home-manager.users.${user} = {
       services.emacs = with pkgs; {
        enable = true;
        package = emacs-pgtk;
      };
     };
  };
}