require('telescope').setup{
  defaults = {
     layout_config = {
      -- vertical = { width = 0.8, height = 0.8 }
      -- other layout configuration here
    },
  },
  pickers = {
    git_files = {
      -- theme = "dropdown",
    },
    buffers = {
      -- theme = "dropdown",
    },
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
}

require("telescope").load_extension "file_browser"
