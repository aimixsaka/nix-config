{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    #languages = {};
    settings = {
      editor = {
        line-number = "relative";
        #auto-info = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys.normal = {
        space.space = ":w";
      };
    };
  };
}
