{
  flake.nixosModules.qtcreator = { pkgs, config, ... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {  
    home.packages = with pkgs; [ 
    qtcreator 
    kdePackages.qtdeclarative
    kdePackages.qtquick3d
    ];   
    }; 
  };  
}
