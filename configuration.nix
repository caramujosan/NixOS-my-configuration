# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # 1. IMPORTS AND HARDWARE
  # ---------------------------------------------------------------------------
  imports =
    [
      # Imports the file generated during hardware detection (disk UUIDs and kernel modules).
      ./hardware-configuration.nix
    ];

  # Configuration for Nvidia with Gnome
  # Load proprietary video drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # 1. Mandatory for Wayland/Gnome to work correctly.
    modesetting.enable = true;

    # 2. Fix scramble pixels. Force saving all VRAM on SSD/RAM before sleep.
    powerManagement.enable = true;

    # Opctional. Deactivate to use closed source traditional driver, BUT
    # open source Nvidia driver (Open Kernel Modules) works fine.
    open = true;
    
    # Ensure the most recent stable package.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ---------------------------------------------------------------------------
  # 2. BOOTLOADER AND File Systems
  # ---------------------------------------------------------------------------
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  # Allows the installer to add the NixOS entry to the emulated motherboard's NVRAM.
  boot.loader.efi.canTouchEfiVariables = true;

  # Deactivate Nouveau video driver to avoid conflict with Nvidia AND
  # ensure Nvidia video driver memory management
  boot.kernelParams = [ "modprobe.blacklist=nouveau" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # ---------------------------------------------------------------------------
  # 3. NETWORK AND LOCALE
  # ---------------------------------------------------------------------------
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # ---------------------------------------------------------------------------
  # 4. GRAPHICAL ENVIRONMENT AND DISPLAY MANAGER
  # ---------------------------------------------------------------------------
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # ---------------------------------------------------------------------------
  # 6. AUDIO SUBSYSTEM (PIPEWIRE)
  # ---------------------------------------------------------------------------
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;
  };

  # ---------------------------------------------------------------------------
  # 7. OTHER SERVICES
  # ---------------------------------------------------------------------------
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # ---------------------------------------------------------------------------
  # 7. SYSTEM PACKAGES AND SHELL HOOKS
  # ---------------------------------------------------------------------------
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Injects the direnv initialization script into the interactive Bash session.
  # programs.bash.interactiveShellInit = ''
  #   eval "$(direnv hook bash)"
  # '';

  # ---------------------------------------------------------------------------
  # 8. USER MANAGEMENT
  # ---------------------------------------------------------------------------
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."caramujosan" = {
    isNormalUser = true;
    description = "caramujosan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # ---------------------------------------------------------------------------
  # 9. AUTOMATIC STORE MAINTENANCE
  # ---------------------------------------------------------------------------
  # Replaces identical files in /nix/store with hard links to save inodes and disk space. 
  nix.settings.auto-optimise-store = true; 

  # Automatic Nix garbage collection. 
  nix.gc = {
  automatic = true; # Enables the systemd timer for cleanup. 
  dates = "weekly"; # Runs weekly. 
  # options = "--delete-older-than -d"; # Removes all store paths not referenced.
  options = "--delete-older-than 7d"; # Removes store paths not referenced for more than 7 days.
  };

  # ---------------------------------------------------------------------------
  # 10. ACTIVATE NIX COMMANDS AND FLAKES
  # ---------------------------------------------------------------------------
  # Enables the new unified `nix` executable and the Flakes architecture.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
