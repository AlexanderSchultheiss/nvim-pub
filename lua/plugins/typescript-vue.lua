-- Split TS/JS and Vue between two LSP servers instead of using LazyVim's
-- `vim.g.lazyvim_ts_lsp` all-or-nothing switch.
--
-- Why: the native TypeScript LSP (`tsc --lsp --stdio`, exposed by
-- nvim-lspconfig as the `tsc` server, formerly previewed as `tsgo`) is much
-- faster than `vtsls`, but it doesn't implement the classic tsserver plugin
-- API, so it can't host `@vue/typescript-plugin` and therefore cannot power
-- Vue SFCs. LazyVim's `lang.vue` extra also hard-assumes `vtsls` is the
-- active server (it does `table.insert(opts.servers.vtsls.filetypes,
-- "vue")`), which throws when `vtsls` isn't loaded — that's the
-- crash/breakage you were hitting when `lazyvim_ts_lsp` was set to `tsgo`.
--
-- Fix: keep both servers enabled, but give them disjoint filetypes:
--   * tsc   -> plain .ts/.tsx/.js/.jsx (fast, native LSP)
--   * vtsls -> .vue only (still backs vue_ls via @vue/typescript-plugin)
--
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers = opts.servers or {}

    -- tsc owns regular TS/JS files.
    opts.servers.tsc = vim.tbl_deep_extend("force", opts.servers.tsc or {}, {
      enabled = true,
      -- Bypass nvim-lspconfig's node_modules-first binary search: it would
      -- otherwise pick up the repo-local TypeScript 5.5.4 `tsc`, which has
      -- no `--lsp` support and crashes on attach. Resolve via $PATH instead
      -- to hit the global TypeScript 7.0.2 install.
      cmd = { "tsc", "--lsp", "--stdio" },
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      settings = {
        ["js/ts"] = {
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
