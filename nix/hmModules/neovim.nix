{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    neovim.enable = lib.mkEnableOption "Enables neovim with config";
  };

  config = lib.mkIf config.neovim.enable {
    # vim = {
    #     theme = {
    #         enable = true;
    #         name = "catppuccin";
    #     };
    # };

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          lsp = {
            enable = true;
          };
          extraPackages = [ pkgs.ripgrep ];
          theme = {
            enable = true;
            name = "catppuccin";
            style = "latte";
          };
          languages = {
            nix.enable = true;

            nim = {
              enable = true;

              lsp = {
                enable = true;
                # package = pkgs.nimlangserver;
              };
              treesitter.enable = true;
            };

            csharp = {
              enable = true;
              lsp.enable = true;
              lsp.server = "omnisharp";
              treesitter.enable = true;
            };

            fsharp = {
              enable = true;
              lsp.enable = true;
              treesitter.enable = true;
              format.enable = true;
            };

            java = {
              enable = true;
              lsp.enable = true;
              treesitter.enable = true;
            };
          };
          treesitter = {
            enable = true;
            textobjects.enable = true;
          };

          autocomplete.nvim-cmp.enable = true;
          telescope = {
            enable = true;
            extensions = [
              {
                name = "fzf";
                packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                setup = {
                  fzf = {
                    fuzzy = true;
                  };
                };
              }
            ];
            setupOpts = {
              pickers.colorscheme.enablePreview = true;
            };
          };
          visuals.nvim-scrollbar.enable = true;
          git.enable = true;
          utility = {
            sleuth.enable = true;
            motion.leap.enable = true;
          };
          binds.whichKey.enable = true;
          statusline.lualine.enable = true;
          comments.comment-nvim.enable = true;
          mini.ai.enable = true;

          clipboard = {
            enable = true;
            # providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };

          undoFile.enable = true;

          options = {
            mouse = "a";
          };
          searchCase = "smart";

          keymaps = [
            {
              mode = [
                "n"
                "v"
              ];
              key = "<Space>";
              action = "<Nop>";
              silent = true;
            }
            # word wrap
            {
              mode = "n";
              key = "k";
              action = "v:count == 0 ? 'gk' : 'k'";
              expr = true;
              silent = true;
            }
            {
              mode = "n";
              key = "j";
              action = "v:count == 0 ? 'gj' : 'j'";
              expr = true;
              silent = true;
            }
            # diagnostics
            # {
            #     mode = "n";
            #     key = "[d";
            #     action = "vim.diagnostic.goto_prev";
            #     silent = true;
            #     lua = true;
            #     desc = "Go to previous diagnostic message";
            # }
            # {
            #     mode = "n";
            #     key = "]d";
            #     action = "vim.diagnostic.goto_next";
            #     silent = true;
            #     lua = true;
            #     desc = "Go to next diagnostic message";
            # }
            {
              mode = "n";
              key = "<leader>e";
              action = "vim.diagnostic.open_float";
              lua = true;
              desc = "Open floating diagnostic message";
            }
            {
              mode = "n";
              key = "<leader>q";
              action = "vim.diagnostic.setloclist";
              lua = true;
              desc = "Open diagnostics list";
            }
            # {
            #     mode = "n";
            #     key = "ü";
            #     action = "<C-I>";
            #     desc = "Go forward";
            # }
            # {
            #     mode = "n";
            #     key = "Ü";
            #     action = "<C-O>";
            #     desc = "Go backward";
            # }
            {
              mode = "n";
              key = "<leader>rn";
              action = "vim.lsp.buf.rename";
              lua = true;
              desc = "[R]e[n]ame";
            }
            {
              mode = "n";
              key = "<leader>ca";
              action = "vim.lsp.buf.code_action";
              lua = true;
              desc = "[C]ode [A]ction";
            }

            # telescope
            {
              desc = "[?] Find recently opened files";
              mode = "n";
              key = "<leader>?";
              action = "require('telescope.builtin').oldfiles";
              lua = true;
            }
            {
              desc = "[ ] Find existing buffers";
              mode = "n";
              key = "<leader><space>";
              action = "require('telescope.builtin').buffers";
              lua = true;
            }
            {
              desc = "[/] Fuzzily search in current buffer";
              mode = "n";
              key = "<leader>/";
              action = "
              function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                    })
              end";
              lua = true;
            }
            {
              desc = "[S]earch [/] in Open Files";
              mode = "n";
              key = "<leader>s/";
              # live_grep_open_files
              action = "
              function() 
                require('telescope.builtin').live_grep {
                  grep_open_files = true,
                  prompt_title = 'Live Grep in Open Files',
                }
              end";
              lua = true;
            }
            {
              desc = "[S]earch [S]elect Telescope";
              mode = "n";
              key = "<leader>ss";
              action = "require('telescope.builtin').builtin";
              lua = true;
            }
            {
              desc = "Search [G]it [F]iles";
              mode = "n";
              key = "<leader>gf";
              action = "require('telescope.builtin').git_files";
              lua = true;
            }
            {
              desc = "[S]earch [F]iles";
              mode = "n";
              key = "<leader>sf";
              action = "require('telescope.builtin').find_files";
              lua = true;
            }
            {
              desc = "[S]earch [H]elp";
              mode = "n";
              key = "<leader>sh";
              action = "require('telescope.builtin').help_tags";
              lua = true;
            }
            {
              desc = "[S]earch current [W]ord";
              mode = "n";
              key = "<leader>sw";
              action = "require('telescope.builtin').grep_string";
              lua = true;
            }
            {
              desc = "[S]earch by [G]rep";
              mode = "n";
              key = "<leader>sg";
              action = "require('telescope.builtin').live_grep";
              lua = true;
            }
            {
              desc = "[S]earch [D]iagnostics";
              mode = "n";
              key = "<leader>sd";
              action = "require('telescope.builtin').diagnostics";
              lua = true;
            }
            {
              desc = "[S]earch [R]esume";
              mode = "n";
              key = "<leader>sr";
              action = "require('telescope.builtin').resume";
              lua = true;
            }
            {
              desc = "[S]earch R[e]ferences";
              mode = "n";
              key = "<leader>se";
              action = "require('telescope.builtin').lsp_references";
              lua = true;
            }
          ];

          augroups = [
            {
              name = "YankHighlight";
              enable = true;
              clear = true;
            }
          ];

          autocmds = [
            {
              event = [ "TextYankPost" ];
              enable = true;
              group = "YankHighlight";
              callback = lib.generators.mkLuaInline ''
                function()
                    vim.highlight.on_yank()
                end
              '';
              pattern = [ "*" ];
            }
          ];

          extraPlugins = with pkgs.vimPlugins; {
            orgmode = {
              package = orgmode;
            };

          };
        };
      };
    };
  };
}
