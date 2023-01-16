-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local keymap = vim.keymap.set -- for conciseness

-- enable keybinds only for when lsp server available
-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

	keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

	-- Code action
	keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

	-- Rename
	keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts)

	-- Peek Definition
	-- you can edit the definition file in this flaotwindow
	-- also support open/vsplit/etc operation check definition_action_keys
	-- support tagstack C-t jump back
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

	-- Go to Definition
	-- keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

	-- Show line diagnostics you can pass arugment ++unfocus to make
	-- show_line_diagnsotic float window unfocus
	keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

	-- Show cursor diagnostic
	-- also like show_line_diagnostics  support pass ++unfocus
	keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

	-- Show buffer diagnostic
	keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

	-- Diagnsotic jump can use `<c-o>` to jump back
	keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

	-- Diagnostic jump with filter like Only jump to error
	keymap("n", "[E", function()
		require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap("n", "]E", function()
		require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	end)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

	-- Callhierarchy
	keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
	keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)

	-- Float terminal
	keymap({ "n", "t" }, "<F7>", "<cmd>Lspsaga term_toggle<CR>")

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
