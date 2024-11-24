{
  autoCmd = [
    # Vertically center document when entering insert mode
    {
      event = "InsertEnter";
      command = "norm zz";
    }
    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }
    # Restore cursor position on opening a file
    {
      event = "BufReadPost";
      pattern = "*";
      command = "lua RestoreCursorPosition()";
    }
    # Automatically create missing directories before saving
    {
      event = "BufWritePre";
      pattern = "*";
      command = ''
        lua << EOF
        -- Disable this autocmd for specific plugins
        local excluded_plugins = { "oil", "neo-tree", "lazy" }
        local filetype = vim.bo.filetype
        for _, plugin in ipairs(excluded_plugins) do
          if filetype == plugin then
            return
          end
        end
        local dir = vim.fn.fnamemodify(vim.fn.expand("<afile>"), ":p:h")
        if not vim.loop.fs_stat(dir) then
          vim.fn.mkdir(dir, "p")
        end
        EOF
      '';
    }
  ];

  ## Remember last cursor position
  ## When editing a file, always jump to the last known cursor position.
  ## Don't do it when the position is invalid, when inside an event handler,
  ## for a commit or rebase message
  ## (likely a different one than last time), and when using xxd(1) to filter
  ## and edit binary files (it transforms input files back and forth, causing
  ## them to have dual nature, so to speak)
  extraConfigLua = ''
    function RestoreCursorPosition()
      local line = vim.fn.line("'\"")
      if
          line > 1
          and line <= vim.fn.line("$")
          and vim.bo.filetype ~= "commit"
          and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
      then
        vim.cmd('normal! g`"')
      end
    end
  '';
}
