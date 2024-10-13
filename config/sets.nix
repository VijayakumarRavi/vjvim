{
  config = {
    opts = {
      # Enable line numbers
      number = true;
      relativenumber = true;

      # Set tabs to 2 spaces
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;

      # Enable auto indenting and set it to spaces
      smartindent = true;
      shiftwidth = 2;

      # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
      breakindent = true;

      # Enable incremental searching
      hlsearch = false;
      incsearch = true;

      # Enable text wrap
      wrap = false;

      # Better splitting
      splitbelow = true;
      splitright = true;

      # Enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true; # Don't ignore case with capitals
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # Decrease updatetime
      updatetime = 50; # faster completion (4000ms default)

      # Set completeopt to have a better completion experience
      completeopt = [
        "menuone"
        "noselect"
        "noinsert"
      ]; # mostly just for cmp

      # Enable persistent undo history
      swapfile = false;
      backup = false;

      # Enable 24-bit colors
      termguicolors = true;

      # Enable the sign column to prevent the screen from jumping
      signcolumn = "yes";

      # Highlight the line where the cursor is located
      cursorline = true;

      # Always keep 10 lines above/below cursor unless at start/end of file
      scrolloff = 10;

      # Set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";

      # Disable mode indicator
      showmode = false;

      # Set fold settings
      # These options were recommended by nvim-ufo
      # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
    };

    # Clipboard provider
    clipboard.register = "unnamedplus";

    extraConfigVim = ''
        if has("persistent_undo")
        let target_path = expand('~/.cache/undodir')

         " create the directory and any parent directories
         " if the location does not exist.
         if !isdirectory(target_path)
             call mkdir(target_path, "p", 0700)
         endif

         let &undodir=target_path
         set undofile
      endif
    '';
  };
}
