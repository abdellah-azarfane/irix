{ pkgs, inputs, lib, ... }:
{
  services.gnome.evolution-data-server.enable = true;

  environment.systemPackages = with pkgs; [
    (python3.withPackages (pyPkgs: with pyPkgs; [ pygobject3 ]))
     inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.sessionVariables = {
    GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" (
      with pkgs;
      [
        evolution-data-server
        libical
        glib.out
        libsoup_3
        json-glib
        gobject-introspection
      ]
    );
  };
}
