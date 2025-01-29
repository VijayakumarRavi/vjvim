_: {
  plugins.transparent.enable = true;

  colorschemes = {
    rose-pine = {
      enable = true;
      settings = {
        style = "dawn";
        transparent = true;
      };
    };
    tokyonight = {
      enable = false;
      settings = {
        style = "night";
        transparent = true;
        onHighlights = ''
          function(hl, c)
              local prompt = "#2d3149"
              hl.TelescopeNormal = {
                  bg = c.bg_dark,
                  fg = c.fg_dark,
              }
              hl.TelescopeBorder = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
              }
              hl.TelescopePromptNormal = {
                  bg = prompt,
              }
              hl.TelescopePromptBorder = {
                  bg = prompt,
                  fg = prompt,
              }
              hl.TelescopePromptTitle = {
                  bg = prompt,
                  fg = prompt,
              }
              hl.TelescopePreviewTitle = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
              }
              hl.TelescopeResultsTitle = {
                  bg = c.bg_dark,
                  fg = c.bg_dark,
              }
              end
        '';
      };
    };
  };
}
