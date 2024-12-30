# System fonts configuration

{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # 0xProto: https://github.com/0xType/0xProto
    _0xproto
    # Cascadia: https://github.com/microsoft/cascadia-code
    cascadia-code
    # Merriweather: https://github.com/SorkinType/Merriweather
    merriweather
    # Merriweather Sans: https://github.com/SorkinType/Merriweather-Sans
    merriweather-sans
    # Noto: https://fonts.google.com/noto
    noto-fonts
    noto-fonts-emoji
    # Liberation: https://github.com/liberationfonts
    liberation_ttf
    # Nerdfonts: https://www.nerdfonts.com/
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
      ];
    })
  ];
}
