{ config, pkgs, ... }: {
  programs.git = {

    enable = true;

    config = {
      user = {
        name = "KyleForan";
        email = "no-reply@null.co";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
