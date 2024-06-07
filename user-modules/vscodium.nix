# VSCodium configuration

{ config, pkgs, ... }:

{
  programs.vscode = {
    # Enable VSCodium
    enable = true;
    package = pkgs.vscodium;
    # Install extensions
    extensions = with pkgs.vscode-extensions; [
      ms-python.python              # Python support
      ms-python.black-formatter     # Python formatter
      ms-pyright.pyright            # Python LSP
      rust-lang.rust-analyzer       # Rust LSP
      vadimcn.vscode-lldb           # LLDB debugger
      llvm-vs-code-extensions.vscode-clangd  # C/C++ LSP
    ];
    # Configure user settings
    userSettings = {
      "editor.minimap.enabled" = false;
      "editor.wordwrap" = "on";
    };
  };
}
