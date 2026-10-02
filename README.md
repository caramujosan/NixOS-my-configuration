# ❄️ NixOS Configuration

Declarative and reproducible **NixOS** system configuration, managed via **Nix Flakes** and **Home Manager**.

Home Manager in NixOS System Module Mode.

## 🛠️ System Architecture

- **OS:** NixOS (26.05)
- **Management:** Nix Flakes + Home Manager
- **Desktop Environment:** GNOME (Wayland)
- **Drivers:** NVIDIA
- **User Tools:** Vim, Direnv with `nix-direnv`, declarative Git, and custom Bash.

## 📁 Repository Structure

```text
.
├── flake.nix                  # Entry point for Nix inputs/outputs
├── configuration.nix          # Global configuration and system services
├── hardware-configuration.nix # Kernel modules and mount points
├── home.nix                   # Declarative user management (Home Manager)
└── bashrc_mine                # Bash startup script (prompt and aliases)
