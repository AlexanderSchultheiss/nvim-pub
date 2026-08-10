-- Split TS/JS and Vue between two LSP servers instead of using LazyVim's
-- `vim.g.lazyvim_ts_lsp` all-or-nothing switch.
--
-- Why: `tsgo` (the native TS Go port) is much faster than `vtsls`, but it
-- doesn't implement the classic tsserver plugin API, so it can't host
-- `@vue/typescript-plugin` and therefore cannot power Vue SFCs. LazyVim's
-- `lang.vue` extra also hard-assumes `vtsls` is the active server (it does
-- `table.insert(opts.servers.vtsls.filetypes, "vue")`), which throws when
-- `vtsls` isn't loaded because `lazyvim_ts_lsp = "tsgo"` was set — that's the
-- crash/breakage you were hitting.
--
-- Fix: keep both servers enabled, but give them disjoint filetypes:
--   * tsgo  -> plain .ts/.tsx/.js/.jsx (fast)
--   * vtsls -> .vue only (still backs vue_ls via @vue/typescript-plugin)
--
-- Requires `tsgo` to be installed (e.g. `npm i -D @typescript/native-preview`
-- in the repo, or globally) since Mason doesn't package it yet.
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    -- tsgo owns regular TS/JS files.
    opts.servers.tsgo = vim.tbl_deep_extend("force", opts.servers.tsgo or {}, {
      enabled = true,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        typescript = {
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = false },
            parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      },
    })

    -- vtsls is scoped to Vue SFCs only; it still carries the Vue plugin
    -- wiring from the `lang.vue` extra, which ran before this file.
    opts.servers.vtsls = opts.servers.vtsls or {}
    opts.servers.vtsls.enabled = true
    opts.servers.vtsls.filetypes = { "vue" }
  end,
}
