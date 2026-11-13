{
  config,
  pkgs,
  ...
}: {
  # Enable Plasma
  services.desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtmultimedia
      qtvirtualkeyboard
    ];
  };

  environment.systemPackages = [pkgs.catppuccin-sddm];

  #   services.displayManager.sddm = {
  #     enable = true;
  #
  #     # To use Wayland (Experimental for SDDM)
  #     wayland.enable = true;
  #   };

  # Optionally enable xserver
  services.xserver.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
  ];
}
