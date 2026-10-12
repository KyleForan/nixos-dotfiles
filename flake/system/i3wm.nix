{
  config,
  pkgs,
  callPackage,
  ...
}: {
  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        polybar
        i3lock
      ];
    };
  };
}
