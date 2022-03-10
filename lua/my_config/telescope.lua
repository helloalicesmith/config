local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local action_state = require("telescope.actions.state")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				-- ["<esc>"] = actions.close,
				["<leader>q"] = actions.send_to_qflist,
			},
			n = {
				["<leader>q"] = actions.send_to_qflist,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
			prompt_position = "top",
		},
		file_sorter = sorters.get_fzy_sorter,
		prompt_prefix = " 🔍 ",
		color_devicons = true,

		sorting_strategy = "ascending",
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
	},
	pickers = {
		find_files = {},
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer,
				},
				n = {
					["<c-d>"] = actions.delete_buffer,
				},
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
		},
	},
})

telescope.load_extension("file_browser")

local M = {}

M.project_files = function()
	local opts = {} -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

local function run_selection(prompt_bufnr)
	actions.select_default:replace(function()
		actions.close(prompt_bufnr)
		local selection = action_state.get_selected_entry()
		vim.cmd([[!git log ]] .. selection[1])
	end)
	return true
end

M.git_log = function()
	-- example for running a command on a file
	local opts = {
		attach_mappings = run_selection,
	}
	builtin.git_files(opts)
end

return M
