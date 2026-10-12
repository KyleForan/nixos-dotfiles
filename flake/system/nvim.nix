{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    lua-language-server
    nil                      # nix LSP
    nixpkgs-fmt
    pyright
    stylua
    ripgrep fd gcc gnumake   # telescope, treesitter compile
  ];
}
