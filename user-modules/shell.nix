# Configuration of the shell and command-line tools

{ config, pkgs, ... }:

let
  # Set aliases for command-line applications
  aliases = {
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    top = "btm";
    ps = "procs";
  };
in {
  # Configure the Z shell
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Use the Powerlevel10k theme
    # It will start the configuration and place the
    # results in `~/.p10k.zsh`
    #initExtra = "source ~/.p10k.zsh || source ~/.zsh/plugins/powerlevel10k/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    initExtra = "source ~/.p10k.zsh || source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    # Use p10k instant prompt
    # It shows the prompt upon zsh startup while
    # plugins are still loading
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
  };

  # Configure the Bourne-Again Shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
  };

  # Useful command-line tools
  home.packages = with pkgs; [
    eza      # Replacement for the venerable file-listing program ls
    bat      # A cat clone with syntax highlighting and Git integration
    bottom   # Graphical process/system monitor
    procs    # A modern replacement for ps
    ripgrep  # A line-oriented search tool
    fd       # A program to find entries in your filesystem
    # Theme for zsh
    zsh-powerlevel10k
  ];
}
