-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.scrolloff = 8
-- opt.shiftwidth = 4
-- opt.tabstop = 4
-- opt.conceallevel = 2

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- LSP Server to use for TypeScript.
--@type "vtsls" | "tsgo"
-- vim.g.lazyvim_ts_lsp = "vtsls" -- currently the default
-- vim.g.lazyvim_ts_lsp = "tsgo" -- currently the default

-- To use the newer, much faster `tsgo` LSP server, either:
-- * enable the `tsgo` extra, or
-- * set `vim.g.lazyvim_ts_lsp = "tsgo"` in your `options.lua`
