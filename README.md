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
└── dotfiles
    ├── my_bashrc                # Bash startup script (prompt and aliases)
    └── my_vimrc
```

## 🛠️ How to Use

### Checking for syntax errors

```bash
nix flake check -v

```

### Testing changes (without saving to bootloader)

```bash
sudo nixos-rebuild test --flake .#nixos

```

### Applying and saving to bootloader

```bash
sudo nixos-rebuild switch --flake .#nixos

```

### Updating the system (Flake inputs)

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos

```
