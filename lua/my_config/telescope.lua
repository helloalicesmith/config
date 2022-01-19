local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
         ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    find_files = {},
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
		},
	},
}

require("telescope").load_extension "file_browser"

local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end


local function run_selection(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    vim.cmd([[!git log ]]..selection[1])
  end)
  return true
end

M.git_log = function()
  -- example for running a command on a file
  local opts = {
    attach_mappings = run_selection
  }
  require"telescope.builtin".git_files(opts)
end

return M


