-- import ts plugin safely
local setup, ts = pcall(require, "syntax-tree-surfer")
if not setup then
	return
end

-- enable
ts.setup()
