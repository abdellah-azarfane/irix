{ ... }:
{
  flake.nixosModules.hardware =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # Bootloader & Kernel
      # Bootloader & Kernel
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.consoleLogLevel = 4;
      boot.supportedFilesystems = [ "ntfs" ];
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
      # Initrd (Hardware specific)
      boot.initrd.availableKernelModules = lib.mkDefault [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      # Kernel Parameters
      boot.kernelParams = [
        "intel_pstate=active"
        "nvidia-drm.fbdev=1"
        "vt.global_cursor_default=0"
        "nowatchdog"
        "btusb.enable_autosuspend=n"
        "i915.enable_psr=2"
      ];
      # Merged Kernel Modules
      boot.kernelModules = [
        "v4l2loopback"
        "kvm-intel"
        "asus-nb-wmi"
        "asus_armoury"
      ];
      # Merged Extra Module Packages
      boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      # Extra Modprobe Config
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
      '';
      # Hardware Support
      hardware.uinput.enable = true;
      hardware.enableAllFirmware = true;
      hardware.enableRedistributableFirmware = true;
      hardware.cpu.intel.updateMicrocode = true;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
            ControllerMode = "dual";
          };
        };
      };
      systemd.services.bluetooth.serviceConfig = {
        CapabilityBoundingSet = "CAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
        ProtectSystem = "";
      };
      systemd.tmpfiles.settings."10-bluetooth" = {
        "/var/lib/bluetooth".d = {
          user = "root";
          group = "root";
          mode = "0700";
        };
      };
      services.dbus.packages = [
        (pkgs.writeTextDir "share/dbus-1/system.d/bluetooth-wireplumber.conf" ''
          <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
           "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
          <busconfig>
            <policy context="default">
              <allow send_interface="org.bluez.MediaEndpoint1"/>
              <allow send_interface="org.bluez.MediaPlayer1"/>
              <allow send_interface="org.bluez.Profile1"/>
              <allow send_interface="org.bluez.GattCharacteristic1"/>
              <allow send_interface="org.bluez.GattDescriptor1"/>
              <allow send_interface="org.bluez.LEAdvertisement1"/>
              <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
              <allow send_interface="org.freedesktop.DBus.Properties"/>
            </policy>
          </busconfig>
        '')
      ];
      services.pipewire.wireplumber.extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.codecs" = [
            "sbc"
            "sbc_xq"
            "aac"
          ];
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
          ];
        };
      };
      hardware.logitech.wireless = {
        enable = true;
      };
      programs.solaar.enable = true;

      # Prevent PowerTOP from suspending Bluetooth USB controller
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{power/autosuspend}="-1"
        ACTION=="add", SUBSYSTEM=="usb", ATTR{manufacturer}=="Realtek", ATTR{power/autosuspend}="-1"
      '';

      # Power & Thermal Management
      powerManagement.powertop.enable = true;
    };
}
