# Configuration of the shell and command-line tools

{ config, pkgs, ... }:

let
  # Set aliases for command-line applications
  aliases = {
    ls = "eza --icons -l -T -L=1"
    cat = "bat"
    top = "btm"
    ps = "procs"
  };
in {
  # Configure the Z shell
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    # Make use of the Powerlevel10k theme
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  }

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
  ]
}
