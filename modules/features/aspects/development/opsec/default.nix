{
  flake.nixosModules.opsec = { pkgs, lib, ...}:
with lib;
{
    environment.systemPackages = with pkgs; [
      # --- Binary Analysis And Reverse Engineering ---
      apktool # Android APK reverse engineering tool
      ghidra # Software reverse engineering suite by NSA
      radare2 # Reverse engineering framework and hex editor

      # --- Brute Forcing And Password Cracking ---
      aircrack-ng # Wireless network security assessment tools
      hashcat # Advanced GPU-based password recovery utility
      hydra # Fast and flexible network logon cracker
      hydra-cli # Command-line interface for Hydra
      john # John the Ripper password security auditing
      johnny # GUI frontend for John the Ripper
      thc-hydra # THC version of Hydra network authentication cracker

      # --- Browser ---
      tor # Anonymous communication and browsing network

      # --- Exploitation Frameworks ---
      metasploit # Penetration testing and exploit development framework

      # --- Forensics And Incident Response ---
      autopsy # Digital forensics platform and GUI
      maltego # Open source intelligence and forensics application

      # --- Information Gathering ---
      nmap # Advanced network scanner and security auditing tool
      social-engineer-toolkit # Social engineering penetration testing framework
      wpscan # WordPress vulnerability scanner

      # --- Network Analysis And Sniffing ---
      kismet # Wireless network detector/sniffer
      snort # Network intrusion detection system
     # wireshark # Network protocol analyzer with deep inspection

      # --- Penetration Testing Tools ---
      burpsuite # Web vulnerability scanner and intercepting proxy
      lynis # Security auditing tool for Unix-based systems
      nikto # Web server scanner for vulnerabilities
      sqlmap # Automatic SQL injection and database takeover tool

      # --- Resources ---
      wordlists # Collection of wordlists for password cracking

      # --- Vulnerability Scanning ---
    ];
  };
}
