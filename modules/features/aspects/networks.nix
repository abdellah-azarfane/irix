{
  flake.nixosModules.networks = { pkgs, config, ...}: {
    environment.systemPackages = with pkgs; [
      # --- Network Packages ---
      networkmanager # Network configuration & management CLI tool
      networkmanagerapplet # GUI for setting up WiFi & Bluetooth
      wireguard-tools # Tools for the WireGuard secure network tunnel
      openresolv # Tool to interact with resolv.conf
      blueman # GUI bluetooth manager
      bluez # Official linux protocol bluetooth stack
      bluez-tools # Set of tools to manage bluetooth devices for linux
      wget # Web file downloader
      nmap # Advanced network scanner and security auditing tool
      xh # A better curl
      acpi # Battery/temperature info\
      doggo # Command line dns client
     # termshark # Terminal UI for tshark/Wireshark
      trippy # Network diagnostic tool like mtr with TUI
      xev
      # --- openssl ---
      openssl
      # --- Pass & Gnupg ---
      # Required by Proton Bridge
      pass
      gnupg
      age
      proton-vpn
      # --- Bitwarden ---
      bitwarden-cli
      ];
    };
  }
