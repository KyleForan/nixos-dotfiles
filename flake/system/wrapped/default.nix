{
  config,
  pkgs,
  ...
}: {
  packages = pkgs: let
    inherit (pkgs) callPackage;
  in {
    bat = callPackage ./wrapped/bat {};
  };
}
