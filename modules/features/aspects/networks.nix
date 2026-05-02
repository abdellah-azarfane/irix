{
  flake.nixosModules.networks = { pkgs, config, ...}: {
    environment.systemPackages = with pkgs; [
      # --- Network Packages ---

      firewalld # Firewall daemon with D-Bus interface
      firewalld-gui # Graphical interface for firewalld
      networkmanager # Network configuration & management CLI tool
      networkmanagerapplet # GUI for setting up WiFi & Bluetooth
      wireguard-tools # Tools for the WireGuard secure network tunnel
      wireguard-ui # Web user interface to manage WireGuard setup
      openresolv # Tool to interact with resolv.conf
      blueman # GUI bluetooth manager
      bluez # Official linux protocol bluetooth stack
      bluez-tools # Set of tools to manage bluetooth devices for linux
      curl # Command line HTTP client
      dig # DNS lookup utility
      ipfetch # Neofetch for IP addresses
      wget # Web file downloader
      wirelesstools # Wireless network configuration tools
      xh # A better curl
      acpi # Battery/temperature info\
      gping # Better ping (includes graph)
      doggo # Command line dns client
      netscanner # TUI network scanner
     # termshark # Terminal UI for tshark/Wireshark
      trippy # Network diagnostic tool like mtr with TUI
      xev
      wdisplays
      # --- openssl ---
      openssl
      # --- Pass & Gnupg ---
      # Required by Proton Bridge
      pass
      gnupg
      age
      sops
      proton-vpn
      # --- Bitwarden ---
      bitwarden-desktop
      bitwarden-cli
      ];
    };
  }
