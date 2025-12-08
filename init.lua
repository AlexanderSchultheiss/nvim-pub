-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.battery")
require("config.texlab")

-- https://github.com/LazyVim/LazyVim/discussions/326
-- Trying to fix vstls performance problem
-- The real problem was too many active buffers and LSP clients stacking.
-- I only use fzf, Harpoon, and a file explorer to switch buffers and never properly close them.
-- This caused LSP clients to accumulate per buffer, and after some time (1–2 hours of usage) my Neovim would start lagging badly.
-- I limited the number of buffers to 10 to prevent this
vim.api.nvim_create_autocmd("BufAdd", {
  callback = function()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if #bufs > 10 then
      for _, buf in ipairs(bufs) do
        if buf.bufnr ~= vim.api.nvim_get_current_buf() then
          vim.cmd("bdelete " .. buf.bufnr)
          break
        end
      end
    end
  end,
})
