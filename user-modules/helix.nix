# Helix text editor configuration
# (https://helix-editor.com/)

{ config, pkgs, ... }:

{
  programs.helix = {
    # Enable Helix text editor
    enable = true;
    # Configure user settings (replaces config.toml)
    settings = {
      editor = {
        completion-replace = true;
        soft-wrap.enable = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
