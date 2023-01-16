local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs and stuff
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- fix backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- sane words
opt.iskeyword:append({ "-", "_" })
-- test_me-im,one!but not me

-- mouse
opt.mouse = "a"
opt.mousemoveevent = true

-- undo
opt.undofile = true

-- make indents nicer
opt.breakindent = true

-- better completion
opt.completeopt = "menuone,noselect"

-- Decrease update time
opt.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set highlight on search
-- opt.hlsearch = false
