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
          obs-multi-rtmp # For multi RTMP output
          obs-backgroundremoval # For background removal
          obs-move-transition # For move transition
        ];
      };

  obsWrapped = inputs.wrapper-modules.lib.wrapPackage {
    inherit pkgs;
    package = obsBase;
    env.LD_LIBRARY_PATH = "/run/opengl-driver/lib"; # for nvidia and nixos i hate this
    env.OBS_USE_EGL = "1";
  };
in
{
  environment.systemPackages = [ obsWrapped ];
};
}
