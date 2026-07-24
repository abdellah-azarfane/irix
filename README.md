# Irix — NixOS Flake Configuration

Personal NixOS configuration for an ASUS TUF F17 M-2023 (main workstation) and a Raspberry Pi 3 GitLab runner.

## Structure

```
├── flake.nix            # Flake entry point, inputs, and outputs
├── flake.lock           # Locked input revisions
├── modules/
│   ├── parts.nix        # Flake-parts options (lib helpers, mkNixos)
│   ├── theme.nix        # Gruvbox-inspired color palette
│   ├── base/            # Core option schemas (user, keymap, monitors, etc.)
│   ├── features/        # Feature modules
│   │   ├── system/      # System-level services & hardware config
│   │   ├── aspects/     # Desktop, dev, media, terminals, etc.
│   │   ├── preferences/ # User preferences (apps, monitors, keymap)
│   │   └── wrappedPrograms/ # Wrapper-module packaged programs
│   └── hosts/           # Host definitions & profiles
│       ├── main/        # Main workstation (disko, nvidia, hardware)
│       ├── pi-runner/   # Raspberry Pi 3 GitLab CI runner
│       └── profiles/    # Profile hierarchy (base → laptop → workstation)
├── secrets/             # SOPS-encrypted secrets
├── emacs-module/        # Standalone Emacs-Kick flake (straight.el)
└── .sops.yaml           # SOPS age key configuration
```

## Profiles

- **base** — Core system, services, hardware, nix-ld
- **laptop** — base + desktop environment
- **main-workstation** — laptop + preferences + NVIDIA + disko
- **server** — base + networks + monitoring + servers (headless)

## Usage

```bash
# Build & switch to main workstation
sudo nixos-rebuild switch --flake .#main

# Build & switch to Pi runner (remote)
nixos-rebuild switch --flake .#pi-runner --target-host root@pi-runner

# Check flake validity
nix flake check

# Update all inputs
nix flake update
```

## Key Conventions

| Namespace       | Purpose                                         |
|-----------------|-------------------------------------------------|
| `preferences.*` | User-facing preferences (apps, theme, monitors) |
| `features.*`    | Optional feature/service toggles                |
| `persistence.*` | Impermanence persistence rules                  |

## Hosts

| Host           | Architecture | Role                              |
|----------------|-------------|-----------------------------------|
| `main`         | x86_64-linux| ASUS TUF GAMING F17  workstation |
| `pi-runner`    | aarch64-linux| Raspberry Pi 3 GitLab CI runner  |
