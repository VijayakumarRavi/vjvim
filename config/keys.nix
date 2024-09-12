{
  globals.mapleader = " ";

  keymaps = [
    # Navigate vim panes better
    {
      mode = "n";
      key = "<c-k>";
      action = ":wincmd k<CR>";
    }
    {
      mode = "n";
      key = "<c-j>";
      action = ":wincmd j<CR>";
    }
    {
      mode = "n";
      key = "<c-h>";
      action = ":wincmd h<CR>";
    }
    {
      mode = "n";
      key = "<c-l>";
      action = ":wincmd l<CR>";
    }

    # control+s to save
    {
      mode = "n";
      key = "<c-s>";
      action = ":w<CR>";
    }
    {
      mode = [
        "i"
        "v"
      ];
      key = "<c-s>";
      action = "<esc>:w<CR>";
    }

    # control+q to save
    {
      mode = "n";
      key = "<c-q>";
      action = ":wq<CR>";
    }
    {
      mode = [
        "i"
        "v"
      ];
      key = "<c-q>";
      action = "<esc>:wq<CR>";
    }
  ];
}
