{pkgs, ...}: {
  #  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };

    promptInit = ''
      bindkey '^U' backward-kill-line                   # ctrl + U
      bindkey '^[[3;5~' kill-word                       # ctrl + Supr
      bindkey '^[[3~' delete-char                       # delete
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-

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

      format = "$env_var$directory$nix_shell$line_break$username$hostname$character";

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

      nix_shell.format = "via [$symbol$state( ($name))]($style) ";
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

    plugins = with pkgs.tmuxPlugins; [
      dotbar
      catppuccin
    ];

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

      set -g mouse on
      set -g mode-keys vi

      set -sg escape-time 10

      set -g @plugin 'catppuccin/tmux#v2.3.2'
      set -g @plugin 'vaaleyard/tmux-dotbar'

      set -g @tmux-dotbar-bg "#1e1e2e"
      set -g @tmux-dotbar-fg "#585b70"
      set -g @tmux-dotbar-fg-current "#cdd6f4"
      set -g @tmux-dotbar-fg-session "#9399b2"
      set -g @tmux-dotbar-fg-prefix "#cba6f7"

      set -g @tmux-dotbar-position top
    '';
  };
}
