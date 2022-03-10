local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local log = require("vim.lsp.log")
local util = require("vim.lsp.util")
local runtime_path = vim.split(package.path, ";")

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local on_attach = function(_, bufnr)
	vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
	vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
	vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
	vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

	buf_map(bufnr, "n", "gi", ":LspImplementation<CR>")
	buf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	buf_map(bufnr, "n", "gd", ":LspDef<CR>")
	buf_map(bufnr, "n", "gr", ":LspRefs<CR>")
	buf_map(bufnr, "n", "gR", ":LspRename<CR>")
	buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
	buf_map(bufnr, "n", "K", ":LspHover<CR>")
	buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
	buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
	buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
	buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
	buf_map(bufnr, "n", "<C-k>", "<cmd> LspSignatureHelp<CR>")
end

require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "<F3>", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
		-- defaults
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",

			-- update imports on file move
			update_imports_on_move = false,
			require_confirmation_on_move = true,
			watch_dir = nil,
		})

		on_attach(client, bufnr)
	end,
	handlers = {
		["textDocument/definition"] = function(_, result, params)
			if result == nil or vim.tbl_isempty(result) then
				local _ = log.info() and log.info(params.method, "No location found")
				return nil
			end

			if vim.tbl_islist(result) then
				util.jump_to_location(result[1])
				if #result > 1 then
					local isReactDTs = false
					for _, value in pairs(result) do
						if string.match(value.uri, "react/index.d.ts") then
							isReactDTs = true
							break
						end
					end
					if not isReactDTs then
						vim.fn.setqflist(util.locations_to_items(result))
						vim.api.nvim_command("copen")
					end
				end
			else
				util.jump_to_location(result)
			end
		end,
	},
})

-- nvim-cmp setup
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
