# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series1
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./packages.nix
    ./sh.nix
    #    ./i3wm.nix
    ./vm.nix
    ./steam.nix
    #     ./nvim
    ./nvim.nix
    #    ./hyprland.nix
    ./container.nix
    ./kde.nix
    ./git.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  boot.initrd.availableKernelModules = ["xhci_pci" "uas" "usbcore" "usb_storage"];
  services.udisks2.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [libseccomp];

  # Ensure latest kernals
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    extraPackages = with pkgs; [
      sddm-astronaut
    ];

    theme = "sugar-dark";
  };

  networking.nameservers = ["192.168.0.141" "192.168.0.1" "1.1.1.1"];
  #   networking.hosts = {
  #     "192.168.0.141" =  ["router.lab" "pihole.lab"];
  #   };

  networking.hostName = "NixTop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Firmware update
  services.fwupd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.default = {
    isNormalUser = true;
    description = "default";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
