# Configuration for the Foot minimalistic Wayland terminal emulator
# https://codeberg.org/dnkl/foot/

{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "0xProto:size=12, CascadiaMono:size=12, SymbolsNerdFontMono:size=12, NotoColorEmoji:size=12";
        font-bold = "0xProto:size=12:weight=bold, CascadiaMono:size=12:weight=bold, SymbolsNerdFontMono:size=12, NotoColorEmoji:size=12";
        font-italic = "0xProto:size=12:slant=italic, CascadiaMono:size=12:slant=italic, SymbolsNerdFontMono:size=12, NotoColorEmoji:size=12";
        font-bold-italic = "0xProto:size=12:weight=bold:slant=italic, CascadiaMono:size=12:weight=bold:slant=italic, SymbolsNerdFontMono:size=12, NotoColorEmoji:size=12";
      };
    };
  };
}