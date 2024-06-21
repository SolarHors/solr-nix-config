# System fonts configuration

{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Merriweather: https://github.com/SorkinType/Merriweather
    merriweather
    # Merriweather Sans: https://github.com/SorkinType/Merriweather-Sans
    merriweather-sans
    # Noto: https://fonts.google.com/noto
    noto-fonts
    noto-fonts-emoji
    # Liberation: https://github.com/liberationfonts
    liberation_ttf
    # Fira Code: https://github.com/tonsky/FiraCode
    fira-code
    # Nerdfonts: https://www.nerdfonts.com/
    (nerdfonts.override {
      fonts = [
        "FiraCode" "FiraMono" "Iosevka" "IosevkaTerm"
      ];
    })
  ];
}
