{ inputs, ... }: {
  flake.lib.diskoConfigurations.MainWorkstation =
    { ... }: {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.main = {
        # Stable ID avoids accidental targeting if disk ordering changes later.
        device = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4a3f3601";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              name = "esp";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              name = "swap";
              # 16G RAM laptop: 20G gives reliable hibernation headroom.
              size = "20G";
              content = {
                type = "swap";
                # Keep a stable swap mapping for hibernate/resume support.
                resumeDevice = true;
              };
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "luks";
                name = "crypted_nixos";
                settings = {
                  # Keep NVMe TRIM support through LUKS for long-term SSD health.
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  # Mount top-level tree to simplify snapshot/imperm workflows.
                  mountpoint = "/.btrfs-root";
                  extraArgs = [ "-f" ];
                  mountOptions = [ "subvolid=5" "compress=zstd:3" "noatime" "ssd" ];
                  subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd:3" "noatime" "ssd" ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd:3" "noatime" "ssd" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd:3" "noatime" "ssd" ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "compress=zstd:3" "noatime" "ssd" ];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zstd:3" "noatime" "ssd" ];
                  };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
