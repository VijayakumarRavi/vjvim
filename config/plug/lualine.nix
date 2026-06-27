_: {
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = {
          normal = {
            a = {
              bg = "#nil";
            };
            b = {
              bg = "nil";
            };
            c = {
              bg = "nil";
            };
            z = {
              bg = "nil";
            };
            y = {
              bg = "nil";
            };
          };
        };
        globalstatus = true;
        disabled_filetypes = {
          statusline = [
            "dashboard"
            "alpha"
            "starter"
          ];
        };
      };
      inactive_sections = {
        lualine_x = [
          "filename"
          "filetype"
        ];
      };
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            fmt = "string.lower";
            color = {
              fg = "908caa";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon.__unkeyed = "";
            color = {
              fg = "908caa";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "diff";
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_c = [
          {
            __unkeyed = "diagnostic";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
            color = {
              fg = "eb6f92";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          "diagnostics"
          {
            __unkeyed-1 = {
              __raw = ''
                opts = function(_, opts)
                    local trouble = require("trouble")
                    local symbols = trouble.statusline({
                      mode = "lsp_document_symbols",
                      groups = {},
                      title = false,
                      filter = { range = true },
                      format = "{kind_icon}{symbol.name:Normal}",
                      hl_group = "lualine_c_normal",
                    })
                    table.insert(opts.sections.lualine_c, {
                      symbols.get,
                      cond = symbols.has,
                    })
                 end
              '';
            };
          }
        ];
        lualine_x = [
          {
            __unkeyed = {
              __raw = ''
                function()
                  local clients = vim.lsp.get_clients({ bufnr = 0 })
                  if #clients == 0 then
                      return ""
                  end
                  local names = {}
                  for _, client in ipairs(clients) do
                      table.insert(names, client.name)
                  end
                  return table.concat(names, ", ")
                end
              '';
            };
            icon = " ";
            color = {
              fg = "908caa";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "encoding";
            color = {
              fg = "908caa";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "fileformat";
            color = {
              fg = "908caa";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_y = [
          {
            __unkeyed = "filetype";
            colored = true;
            icon_only = true;
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = "filename";
            symbols = {
              modified = "";
              readonly = "👁️";
              unnamed = "";
            };
            color = {
              fg = "e0def4";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
        lualine_z = [
          {
            __unkeyed = "location";
            color = {
              fg = "31748f";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
          {
            __unkeyed = {
              __raw = ''
                function()
                  return tostring(vim.api.nvim_buf_line_count(0)) .. " lines"
                end
              '';
            };
            color = {
              fg = "31748f";
              bg = "nil";
            };
            separator.left = "";
            separator.right = "";
          }
        ];
      };
    };
  };
}
