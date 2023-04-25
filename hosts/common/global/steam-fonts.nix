{ pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      source-code-pro
      source-han-mono
      source-han-sans
      source-han-serif
      #inconsolata
      # Chinese Specified
      # NOTE: steam need wqy_zenhei to display chinese
      # and also cannot use fontconfig.defaultFonts
      # otherwise will comes into 'steam chinese tofu'
      wqy_zenhei
      # wqy_microhei
      # twitter-emoji
      twitter-color-emoji
      # Nerd Fonts
      #nerdfonts
      (nerdfonts.override { fonts = [ "Inconsolata" "SourceCodePro" ]; })
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      # use user config
      includeUserConf = true;
      # NOTE: it seems this config will also makes steam chinese 'tofu'
      #localConf = ''
      #  <?xml version="1.0"?>
      #  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      #  <fontconfig>
      #  
      #    <!-- Default system-ui fonts -->
      #    <match target="pattern">
      #      <test name="family">
      #        <string>system-ui</string>
      #      </test>
      #      <edit name="family" mode="prepend" binding="strong">
      #        <string>sans-serif</string>
      #      </edit>
      #    </match>
      #  
      #    <!-- Default sans-serif fonts -->
      #    <match target="pattern">
      #      <test name="family">
      #        <string>sans-serif</string>
      #      </test>
      #      <edit name="family" mode="prepend" binding="strong">
      #        <string>Noto Sans CJK SC</string>
      #        <string>Noto Sans</string>
      #        <string>Twemoji</string>
      #      </edit>
      #    </match>
      #  
      #    <!-- Default serif fonts -->
      #    <match target="pattern">
      #      <test name="family">
      #        <string>serif</string>
      #      </test>
      #      <edit name="family" mode="prepend" binding="strong">
      #        <string>Noto Serif CJK SC</string>
      #        <string>Noto Serif</string>
      #        <string>Twemoji</string>
      #      </edit>
      #    </match>
      #  
      #    <!-- Default monospace fonts -->
      #    <match target="pattern">
      #      <test name="family">
      #        <string>monospace</string>
      #      </test>
      #      <edit name="family" mode="prepend" binding="strong">
      #        <string>Noto Sans Mono CJK SC</string>
      #        <string>Inconsolata Nerd Font</string>
      #        <string>Twemoji</string>
      #      </edit>
      #    </match>
      #  
      #    <!-- language specific config -->
      #    <match target="pattern">
      #      <test name="lang">
      #        <string>zh-cn</string>
      #      </test>
      #      <test name="family">
      #        <string>Noto Sans CJK SC</string>
      #      </test>
      #      <edit name="family" binding="strong">
      #        <string>Noto Sans CJK SC</string>
      #      </edit>
      #    </match>
      #  
      #    <match target="pattern">
      #      <test name="lang">
      #        <string>zh-hk</string>
      #      </test>
      #      <test name="family">
      #        <string>Noto Sans CJK SC</string>
      #      </test>
      #      <edit name="family" binding="strong">
      #        <string>Noto Sans CJK HK</string>
      #      </edit>
      #    </match>
      #  
      #    <match target="pattern">
      #      <test name="lang">
      #        <string>ja</string>
      #      </test>
      #      <test name="family">
      #        <string>Noto Sans CJK SC</string>
      #      </test>
      #      <edit name="family" binding="strong">
      #        <string>Noto Sans CJK JP</string>
      #      </edit>
      #    </match>
      #  
      #    <match target="pattern">
      #      <test name="lang">
      #        <string>ko</string>
      #      </test>
      #      <test name="family">
      #        <string>Noto Sans CJK SC</string>
      #      </test>
      #      <edit name="family" binding="strong">
      #        <string>Noto Sans CJK KR</string>
      #      </edit>
      #    </match>
      #  
      #    <!-- override english on chinese fonts -->
      #    <match target="pattern">
      #      <test name="lang" compare="contains">
      #        <string>en</string>
      #      </test>
      #      <test name="family" compare="contains">
      #        <string>Noto Sans CJK</string>
      #      </test>
      #      <edit name="family" mode="prepend" binding="strong">
      #        <string>Noto Sans</string>
      #      </edit>
      #    </match>
      #  </fontconfig>
      #'';
    };
  };
}
