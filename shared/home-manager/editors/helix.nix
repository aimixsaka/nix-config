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
        "C-j" = "copy_selection_on_next_line";
        "C-k" = "copy_selection_on_prev_line";
        "C-`" = "switch_to_uppercase";
        "C-," = "remove_primary_selection";
        "C-;" = "flip_selections";
        "C-s" = "split_selection_on_newline";
        "C-r" = "remove_selections";
        "C-v" = "save_selection";
        "C-minus" = "merge_selections";
        "C-_" = "merge_consecutive_selections";
        # tree sitter related
        "C-t" = {
          a = "select_all_siblings";
          e = "move_parent_node_end";
          E = "extend_parent_node_end";
          b = "move_parent_node_start";
          B = "extend_parent_node_start";
        };
      };
    };
  };
}
