{
  config,
  pkgs,
  ...
}: let
  wrapped-bat = import ./wrapped/bat.nix {inherit pkgs;};
in {
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
    python3
    uv
    lazygit
    luarocks
    shellcheck
    powershell
    alejandra
    rustc
    cargo
    nodejs
    typescript
    nodemon

    # Shell
    ghostty
    zoxide
    fzf
    jq
    xclip
    eza
    ripgrep
    wrapped-bat
    feh
    calcurse
    tldr
    starship

    rofi

    # nvim
    yazi
    tree-sitter
    gcc
    gnumake

    # Web
    firefox
    wget
    curl
    httpie
    librewolf

    # College
    libreoffice

    # Social
    discordo

    p7zip
    obsidian
    dnsmasq
    flameshot
    xfconf
    thunar
    psmisc
    pavucontrol
    prismlauncher
    retroarch-free
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
