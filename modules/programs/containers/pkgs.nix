{
  flake.modules.homeManager.containers =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        podman-tui
        kubectl
        kubernetes-helm
        kubectx
        docker
        qemu
        kvmtool
      ];

    };
  flake.modules.nixos.containers =
    { pkgs, ... }:
    {
      services.podman = {
        enable = true;
      };
    };

}
