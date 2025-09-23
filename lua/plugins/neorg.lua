if true then
  return {}
end

return {
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.summary"] = {},
          ["core.journal"] = { -- Manages Neorg workspaces
            config = {
              workspace = "journal",
              journal_folder = "logs",
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                journal = "~/journal/",
              },
              default_workspace = "journal",
            },
          },
        },
      })
    end,
  },
}
