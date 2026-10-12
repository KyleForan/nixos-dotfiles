{
  config,
  pkgs,
  ...
}:
let
  wrapped-bat = import ./wrapped/bat.nix { inherit pkgs; };
in
{
  services.picom.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/default/.dotfiles/flake"; # sets NH_OS_FLAKE variable for you
  };

  services.tailscale.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [

    # Coding
    python3 lazygit luarocks
    shellcheck powershell alejandra

    # Shell
    ghostty zoxide fzf
    jq xclip eza ripgrep

    rofi

    # nvim
    yazi tree-sitter
    gcc gnumake

    # Web
    firefox wget curl httpie

    p7zip
    starship
    tldr
    wrapped-bat
    feh
    obsidian
    dnsmasq
    flameshot
    xfconf
    thunar
    psmisc
    pavucontrol
    prismlauncher
    calcurse
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
