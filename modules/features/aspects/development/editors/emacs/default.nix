{
  flake.nixosModules.emacs = { pkgs, config, ... }:
let
  user = config.preferences.user.name;
in {
   home-manager.users.${user} = {
     programs.emacs = {
       enable = true;
       package = pkgs.emacs-pgtk;
     };

     services.emacs = {
       enable = true;
       client.enable = true;
     };
   };
  };
 }
