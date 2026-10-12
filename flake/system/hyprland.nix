{
  config,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #  hardware.opengl.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    # Wayland Bar
    waybar

    # Notifications
    dunst
    libnotify

    # App Launcher
    rofi

    # brightness control
    brightnessctl

    # -- HyprEcosystem
    # blue light filter
    hyprsunset

    # wallpaper engine
    hyprpaper

    # lock screen
    hyprlock
  ];

  # For Screensharing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
