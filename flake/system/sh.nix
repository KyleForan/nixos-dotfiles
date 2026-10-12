{
  pkgs,
  ...
}:
{
  #  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };

    promptInit = ''
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word

      source <(fzf --zsh)
      eval "$(zoxide init zsh)"

      bindkey -r '\ec'
      bindkey '^F' fzf-cd-widget
    '';
  };

  # $git_branch
  # $git_commit
  # $git_state
  # $git_status

  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;

      format = "$env_var$directory$fill$line_break$username$hostname$character";

      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        format = "@[$ssh_symbol$hostname]($style) ";
      };

      # nix_shell.format = "via [$symbol$state( ($name))]($style) ";
      env_var = {
        variable = "STARSHIP_SHELL";
        format = "\\[[$env_value](light blue bold)\\] ";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        truncation_symbol = "../";
      };

      fill.symbol = " ";
    };
  };

  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;

  environment.shellAliases = {
    ls = "eza --git --icons";
    lta = "eza --icons -AT -L3";
    ltf = "eza --icons -AT";
    tree = "eza --git --icons -AT";

    cat = "bat";
    cd = "z";

    vi = "nvim";
    vim = "nvim";

    svi = "sudo nvim";
    rebuild = "nh os switch";
  };

  programs.tmux = {
    enable = true;

    shortcut = "a";
    terminal = "screen-256color";
    newSession = true;
    baseIndex = 1;

    extraConfig = ''

      bind  c  new-window      -c "#{pane_current_path}"
      bind '-' split-window -v -c "#{pane_current_path}"
      bind '=' split-window -h -c "#{pane_current_path}"

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      set-option -ga terminal-overrides ",*:Tc"

      set-option -g allow-rename off
    '';
  };
}
