# Fresh Install (Flake + Disko)

This guide is destructive. It will wipe the target NVMe and recreate partitions, filesystems, and encrypted volumes from your flake config.

## Target Disk

Configured disk path:

- /dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4a3f3601

## 1) Boot Live ISO and Verify Disk

```bash
sudo -i
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL
readlink -f /dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b4a3f3601
```

If the path does not resolve to your laptop NVMe, stop.

## 2) Clone Flake Repo

```bash
cd /tmp
git clone <your-repo-url> irix
cd irix
```

## 3) Optional: Generate nixos-facter Report

```bash
nix shell nixpkgs#nixos-facter -c nixos-facter > modules/hosts/main/facter.json
```

## 4) Partition + Format with Disko (Destructive)

```bash
nix run github:nix-community/disko -- --mode disko --flake .#main
```

## 5) Install NixOS from Flake

```bash
nixos-install --flake .#main
```

## 6) Reboot

```bash
reboot
```

## Notes

- You will be prompted for the LUKS passphrase during setup/boot.
- zram (50%) and hibernation resume are already configured in this repo.
- Disconnect external drives before running Disko to reduce risk.
