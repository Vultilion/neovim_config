-- leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap.set -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>")

-- save buffer
keymap("n", "<leader>w", ":w<CR>")

-- source buffer
keymap("n", "<leader>so", ":so<CR>")

-- quit buffer
keymap("n", "<leader>q", ":bd | bnext<CR>")

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap("n", "x", '"_x')

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>") -- increment
keymap("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>") -- close current split window

-- nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap("n", "<leader>ff", "<cmd>Telescope fd<cr>") -- find files within current working directory, respects .gitignore
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>") -- list available keymaps
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>") -- list available keymaps
keymap("n", "<leader>fr", "<cmd>Telescope registers<cr>") -- list available registers

-- telescope git commands (not on youtube nvim video)
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap("n", "<leader>gcc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
keymap("n", "<leader>gf", "<cmd>Telescope git_files<cr>") -- git files

-- restart lsp server (not on youtube nvim video)
keymap("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

--move lines
keymap("n", "<leader>k", ":m-2<CR>") --move line up
keymap("n", "<leader>j", ":m+1<CR>") --move line down

-- remapped up and down with centering now
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- bufferline
keymap("n", "<leader>bh", "<cmd>BufferLineCyclePrev<cr>")
keymap("n", "<leader>bl", "<cmd>BufferLineCycleNext<cr>")
keymap("n", "<leader>bj", "<cmd>BufferLinePickClose<cr>")
keymap("n", "<leader>bk", "<cmd>BufferLinePick<cr>")

-- ---------- Treesitter surver ----------
-- Syntax Tree Surfer
local opts = { noremap = true, silent = true }
-- Visual Selection from Normal Mode
keymap("n", "vx", "<cmd>STSSelectMasterNode<cr>", opts)
keymap("n", "vn", "<cmd>STSSelectCurrentNode<cr>", opts)

-- Select Nodes in Visual Mode
keymap("x", "J", "<cmd>STSSelectNextSiblingNode<cr>", opts)
keymap("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>", opts)
keymap("x", "H", "<cmd>STSSelectParentNode<cr>", opts)
keymap("x", "L", "<cmd>STSSelectChildNode<cr>", opts)

-- Swapping Nodes in Visual Mode
keymap("x", "<C-j>", "<cmd>STSSwapNextVisual<cr>", opts)
keymap("x", "<C-k>", "<cmd>rTSSwapPrevVisual<cr>", opts)
