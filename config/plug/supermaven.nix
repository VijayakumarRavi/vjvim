{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    supermaven-nvim
  ];
  extraConfigLua = ''
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<CR>", -- accept the current suggestion
        next_suggestion = "<C-j>", -- move to the next suggestion
        previous_suggestion = "<C-k>", -- move to the previous suggestion
        clear_suggestion = "<Del>", -- clear the current suggestion
      },
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      condition = function()
        return false
      end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
    });
  '';
  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = ":SupermavenToggle<CR>";
      options = {
        desc = "Toggle supermaven-nvim";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ms";
      action = ":SupermavenStatus<CR>";
      options = {
        desc = "Show supermaven-nvim status";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>mj";
      action = ":SupermavenJump<CR>";
      options = {
        desc = "Jump to the next suggestion";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>mk";
      action = ":SupermavenKill<CR>";
      options = {
        desc = "Kill the current suggestion";
        silent = true;
      };
    }
  ];
}
