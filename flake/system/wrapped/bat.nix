{pkgs}:
pkgs.symlinkJoin {
  name = "bat";
  paths = [pkgs.bat]; # Original package
  buildInputs = [pkgs.makeWrapper];
  postBuild = ''
    wrapProgram $out/bin/bat \
      --set BAT_THEME ""Catppuccin\ Mocha # Example theme; replace with your preferred variant
  '';
}
