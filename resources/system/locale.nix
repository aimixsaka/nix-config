{ lib
, pkgs
, ...
}:

{
  # Select internationalisation properties.
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";

  # FIXME: will this affect system font?
    extraLocaleSettings = {
      # LC_ADDRESS = lib.mkDefault "zh_CN.UTF-8";
      # LC_IDENTIFICATION = lib.mkDefault "zh_CN.UTF-8";
      # LC_MEASUREMENT = lib.mkDefault "zh_CN.UTF-8";
      # LC_MONETARY = lib.mkDefault "zh_CN.UTF-8";
      # LC_NAME = lib.mkDefault "zh_CN.UTF-8";
      # LC_NUMERIC = lib.mkDefault "zh_CN.UTF-8";
      # LC_PAPER = lib.mkDefault "zh_CN.UTF-8";
      # LC_TELEPHONE = lib.mkDefault "zh_CN.UTF-8";
      # LC_TIME = lib.mkDefault "zh_CN.UTF-8";
    };
  };

  # FIXME: system-wide font configuration is bad habit!
  # fonts
    # FIXME: check if this is truely inneed?
    #enableDefaultFonts = true;
    # fontconfig = {
    #   defaultFonts = {
    #     serif = [ 
    #       "Noto Serif"
    #       "Noto Color Emoji" 
    #       "Noto Serif CJK SC"
    #       "WenQuanYi Micro Hei"
    #     ];
    #     sansSerif = [
    #       "Inconsolata Nerd Font"
    #       "SauceCodePro Nerd Font" 
    #       "Noto Sans CJK SC"
    #       "WenQuanYi Micro Hei"
    #       "Noto Sans CJK JP" 
    #       "Noto Color Emoji" 
    #     ];
    #     monospace = [
    #       "Inconsolata Nerd Font Mono"
    #       "SauceCodePro Nerd Font Mono" 
    #       "Noto Sans Mono CJK SC"
    #       "WenQuanYi Micro Hei Mono"
    #       "Noto Sans Mono CJK JP"
    #       "Noto Color Emoji" 
    #     ];
    #     emoji = ["Noto Color Emoji"];
    #   };
    # };
  #};

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      source-code-pro
      inconsolata

      # Chinese Specified
      # NOTE: steam need wqy_zenhei to display chinese
      # and also cannot use fontconfig.defaultFonts
      # otherwise will comes into 'steam chinese tofu'
      wqy_zenhei
      # wqy_microhei
      twemoji-color-font
      twitter-color-emoji
      # only need symbols from nerdfonts
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      #(nerdfonts.override { fonts = [ "Inconsolata" "SourceCodePro" ]; })
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      # use user config
      includeUserConf = true;
      # NOTE: it seems this config will also makes steam chinese 'tofu'
      localConf = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<!-- Generic config -->
<fontconfig>

  <!-- Default system-ui fonts -->
  <match target="pattern">
    <test name="family">
      <string>system-ui</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>sans-serif</string>
    </edit>
  </match>

  <!-- Default sans-serif fonts-->
  <match target="pattern">
    <test name="family">
      <string>sans-serif</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Sans CJK SC</string>
      <string>Noto Sans</string>
      <string>Symbols Nerd Font</string>
      <string>Twitter Color Emoji</string>
    </edit>
  </match>

  <!-- Default serif fonts-->
  <match target="pattern">
    <test name="family">
      <string>serif</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Serif CJK SC</string>
      <string>Noto Serif</string>
      <string>Symbols Nerd Font</string>
      <string>Twitter Color Emoji</string>
    </edit>
  </match>

  <!-- Default monospace fonts-->
  <match target="pattern">
    <test name="family">
      <string>monospace</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <!-- <string>RobotoMono</string> -->
      <string>Inconsolata</string>
      <string>Noto Sans Mono CJK SC</string>
      <string>Noto Sans Mono</string>
      <string>Symbols Nerd Font</string>
      <string>Twitter Color Emoji</string>
    </edit>
  </match>




  <!-- noto-cjk config -->
  <match target="pattern">
    <test name="lang">
      <string>zh-HK</string>
    </test>
    <test name="family">
      <string>Noto Sans CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans CJK HK</string>
    </edit>
  </match>

  <!-- noto-serif -->
  <match target="pattern">
    <test name="lang">
      <string>zh-HK</string>
    </test>
    <test name="family">
      <string>Noto Serif CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <!-- do not have HK for serif -->
      <string>Noto Serif CJK TC</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>zh-HK</string>
    </test>
    <test name="family">
      <string>Noto Sans Mono CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans Mono CJK HK</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>zh-TW</string>
    </test>
    <test name="family">
      <string>Noto Sans CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans CJK TC</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>zh-TW</string>
    </test>
    <test name="family">
      <string>Noto Serif CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Serif CJK TC</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>zh-TW</string>
    </test>
    <test name="family">
      <string>Noto Sans Mono CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans Mono CJK TC</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ja</string>
    </test>
    <test name="family">
      <string>Noto Sans CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans CJK JP</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ja</string>
    </test>
    <test name="family">
      <string>Noto Serif CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Serif CJK JP</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ja</string>
    </test>
    <test name="family">
      <string>Noto Sans Mono CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans Mono CJK JP</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ko</string>
    </test>
    <test name="family">
      <string>Noto Sans CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans CJK KR</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ko</string>
    </test>
    <test name="family">
      <string>Noto Serif CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Serif CJK KR</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang">
      <string>ko</string>
    </test>
    <test name="family">
      <string>Noto Sans Mono CJK SC</string>
    </test>
    <edit name="family" binding="strong">
      <string>Noto Sans Mono CJK KR</string>
    </edit>
  </match>

  <!-- en specific -->
  <match target="pattern">
    <test name="lang" compare="contains">
      <string>en</string>
    </test>
    <test name="family" compare="contains">
      <string>Noto Sans CJK</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Sans</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang" compare="contains">
      <string>en</string>
    </test>
    <test name="family" compare="contains">
      <string>Noto Serif CJK</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Serif</string>
    </edit>
  </match>

  <!-- another method focus on ' and ’ -->
  <!-- cn specific -->
  <!--
  <match target="pattern">
    <test name="lang" compare="contains">
      <string>cn</string>
    </test>
    <test name="family" compare="contains">
      <string>Noto Sans</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Sans CJK SC</string>
    </edit>
  </match>

  <match target="pattern">
    <test name="lang" compare="contains">
      <string>cn</string>
    </test>
    <test name="family" compare="contains">
      <string>Noto Serif</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Serif CJK SC</string>
    </edit>
  </match>
  -->

</fontconfig>
      '';
    };
  };
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
}
