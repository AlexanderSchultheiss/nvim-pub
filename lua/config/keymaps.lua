-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = LazyVim.safe_keymap_set

-- ThePrimegean
-- J without cursor move
map("n", "J", "mzJ`z")
-- cursor staying in the middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- paste without loosing paste buffer
map("x", "<leader>p", '"_dP', { desc = "paste and keep buffer" })
-- yank into system clipboard
map("n", "<leader>y", '"+y', { desc = "yank into system clipboard" })
map("v", "<leader>y", '"+y', { desc = "yank into system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "yank EOL into system clipboard" })
-- delete to void buffer
map("n", "<leader>dd", '"_d', { desc = "delete into void" })
map("v", "<leader>dd", '"_d', { desc = "delete into void" })
-- misc
map("n", "Q", "<nop>")
-- navigate error list
map("n", "<S-Down>", "<cmd>cnext<CR>zz")
map("n", "<S-Up>", "<cmd>cprev<CR>zz")
-- navigate location list
map("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "next location" })
map("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "previous location" })

-- todos
map("n", "<leader>T", "<cmd>:TodoQuickFix<CR>", { desc = "load todos into quickfix" })

-- vimtex
-- vim.g.vimtex_mappings_prefix = "<leader>l"
-- vim.g.vimtex_imaps_leader = "#"
-- map("n", "<leader>li", "<Plug>(vimtex-info)", { desc = "vimtex info" })
-- map("n", "<leader>ll", "<Plug>(vimtex-compile)", { desc = "vimtex compile" })

-- map("n", "<leader>v[[", "<Plug>(vimtex-[[)", { desc = "section vimtex-[[" })
-- map("n", "<leader>v]]", "<Plug>(vimtex-]])", { desc = "section vimtex-]]" })
-- map("n", "<leader>v[]", "<Plug>(vimtex-[])", { desc = "section vimtex-[]" })
-- map("n", "<leader>v][", "<Plug>(vimtex-][)", { desc = "section vimtex-][" })
--
-- map("n", "<leader>v[m", "<Plug>(vimtex-[m)", { desc = "env. vimtex-[m" })
-- map("n", "<leader>v[M", "<Plug>(vimtex-[M)", { desc = "env. vimtex-[M" })
-- map("n", "<leader>v]m", "<Plug>(vimtex-]m)", { desc = "env. vimtex-]m" })
-- map("n", "<leader>v]M", "<Plug>(vimtex-]M)", { desc = "env. vimtex-]M" })
--
-- map("n", "<leader>v[n", "<Plug>(vimtex-[n)", { desc = "math vimtex-[n" })
-- map("n", "<leader>v[N", "<Plug>(vimtex-[N)", { desc = "math vimtex-[N" })
-- map("n", "<leader>v]n", "<Plug>(vimtex-]n)", { desc = "math vimtex-]n" })
-- map("n", "<leader>v]N", "<Plug>(vimtex-]N)", { desc = "math vimtex-]N" })
--
-- map("n", "<leader>v[r", "<Plug>(vimtex-[r)", { desc = "frame vimtex-[r" })
-- map("n", "<leader>v[R", "<Plug>(vimtex-[R)", { desc = "frame vimtex-[R" })
-- map("n", "<leader>v]r", "<Plug>(vimtex-]r)", { desc = "frame vimtex-]r" })
-- map("n", "<leader>v]R", "<Plug>(vimtex-]R)", { desc = "frame vimtex-]R" })
--
-- map("n", "<leader>v[*", "<Plug>(vimtex-[*)", { desc = "comment vimtex-[*" })
-- map("n", "<leader>v]*", "<Plug>(vimtex-]*)", { desc = "comment vimtex-]*" })

-- undotree
map("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "undotree toggle " })

-- Neorg
map({ "v", "n" }, "<localleader>jn", "<cmd>Neorg journal today<CR>", { desc = "edit today's journal" })
map({ "v", "n" }, "<localleader>jj", "<cmd>Neorg journal<CR>", { desc = "Neorg journal mode" })
map({ "v", "n" }, "<localleader>wj", "<cmd>Neorg workspace journal<CR>", { desc = "open the journal" })
map({ "v", "n" }, "<localleader>wr", "<cmd>Neorg return<CR>", { desc = "exit neorg workspace" })
map({ "v", "n" }, "<localleader>im", "<cmd>Neorg inject-metadata<CR>", { desc = "inject metadata" })
map({ "v", "n" }, "<localleader>iu", "<cmd>Neorg update-metadata<CR>", { desc = "update metadata" })
map({ "v", "n" }, "<localleader>o", "<cmd>Neorg toc<CR>", { desc = "table of contents" })
map({ "v", "n" }, "<localleader>r", "<cmd>Neorg render-latex<CR>", { desc = "render latex" })
map({ "v", "n" }, "<A-t>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "task cycle" })
map({ "v", "n" }, "<localleader>ww", function()
  vim.ui.input({ prompt = "Enter Workspace Name: " }, function(input)
    if input then
      vim.cmd("Neorg workspace " .. input)
    end
  end)
end, { desc = "Switch neorg workspace" })
map({ "v", "n" }, "<localleader>ss", "<cmd>Neorg generate-workspace-summary<CR>", { desc = "Neorg workspace summary" })
map({ "v", "n" }, "<localleader>sp", function()
  vim.ui.input({ prompt = "Enter Category Names: " }, function(input)
    if input then
      vim.cmd("Neorg generate-workspace-summary " .. input)
    end
  end)
end, { desc = "Neorg partial workspace summary" })

-- Zenmode
map({ "v", "n" }, "<leader>uz", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })
