{
  flake.modules.homeManager.niri =
    { pkgs, ... }:
    {
      programs.niri.settings = {
        # ============================================================================
        # Animations
        # ============================================================================
        animations = {
          slowdown = 0.8;

          window-open.kind.easing = {
            duration-ms = 150;
            curve = "ease-out-expo";
          };

          window-close.kind.easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
          };

          horizontal-view-movement.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          window-movement.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          window-resize.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };

          config-notification-open-close.kind.spring = {
            damping-ratio = 0.6;
            stiffness = 1000;
            epsilon = 0.001;
          };

          screenshot-ui-open.kind.easing = {
            duration-ms = 200;
            curve = "ease-out-quad";
          };

          overview-open-close.kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };
    };
}
