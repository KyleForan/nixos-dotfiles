{
  config,
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #  hardware.opengl.enable = true;
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    ashell

    # Notifications
    dunst
    libnotify

    # App Launcher
    hyprlauncher

    # brightness control
    brightnessctl

    # -- HyprEcosystem
    # blue light filter
    hyprsunset

    # wallpaper engine
    hyprpaper

    # lock screen
    hyprlock

    # Screenshots
    grim
    slurp
    swappy

    # Clipboard
    wl-clipboard
  ];

  # For Screensharing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
