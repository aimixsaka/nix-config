{
  pkgs,
  ...
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      # needed enable rime using configtool after installed
      fcitx5-configtool
      fcitx5-mozc
      fcitx5-rime
      fcitx5-gtk # gtk im module
    ];
    fcitx5.settings = {
      inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "rime";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "rime";
        "Groups/0/Items/2".Name = "mozc";
      };
      globalOptions = {
        Hotkey = {
          EnumerateWithTriggerKeys = true;
          EnumerateForwardKeys = "";
          EnumerateBackwardKeys = "";
          EnumerateSkipFirst = false;
          EnumerateGroupForwardKeys = "";
          EnumerateGroupBackwardKeys = "";
          TogglePreedit = "";
          ModifierOnlyKeyTimeout = 250;
        };

        "Hotkey/TriggerKeys" = {
          "0" = "Control+Shift+space";
          "1" = "Zenkaku_Hankaku";
          "2" = "Hangul";
        };

        "Hotkey/AltTriggerKeys" = {
          "0" = "Shift_L";
        };

        "Hotkey/ActivateKeys" = {
          "0" = "Hangul_Hanja";
        };

        "Hotkey/DeactivateKeys" = {
          "0" = "Hangul_Romaja";
        };

        "Hotkey/PrevPage" = {
          "0" = "Up";
        };

        "Hotkey/NextPage" = {
          "0" = "Down";
        };

        "Hotkey/PrevCandidate" = {
          "0" = "Shift+Tab";
        };

        "Hotkey/NextCandidate" = {
          "0" = "Tab";
        };

        Behavior = {
          ActiveByDefault = false;
          resetStateWhenFocusIn = "No";
          ShareInputState = "No";
          PreeditEnabledByDefault = true;
          ShowInputMethodInformation = true;
          showInputMethodInformationWhenFocusIn = false;
          CompactInputMethodInformation = true;
          ShowFirstInputMethodInformation = true;
          DefaultPageSize = 5;
          OverrideXkbOption = false;
          CustomXkbOption = "";
          EnabledAddons = "";
          DisabledAddons = "";
          PreloadInputMethod = true;
          AllowInputMethodForPassword = false;
          ShowPreeditForPassword = false;
          AutoSavePeriod = 30;
        };
      };

    };
  };
}
