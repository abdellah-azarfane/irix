{ flake.nixosModules.obs = { pkgs, inputs, ... }:

let
  obsBase =
    pkgs.wrapOBS.override
      {
        obs-studio = pkgs.obs-studio.override { cudaSupport = true; };
      }
      {
        plugins = with pkgs.obs-studio-plugins; [
          obs-pipewire-audio-capture # For PipeWire audio capture
          wlrobs # For Wayland screen capture
          obs-vkcapture # For Vulkan screen capture
          aitum-stream-suite # For Aitum stream suite
          obs-multi-rtmp # For multi RTMP output
          obs-backgroundremoval # For background removal
          obs-move-transition # For move transition
          obs-3d-effects # For 3D effects
        ];
      };

  obsWrapped = inputs.wrapper-modules.lib.wrapProgram {
    inherit pkgs;
    modules = [
      {
        package = obsBase;
        env.LD_LIBRARY_PATH = "/run/opengl-driver/lib"; # for nvidia and nixos i hate this
      }
    ];
  };
in
{
  environment.systemPackages = [ obsWrapped ];
 };
}
