require("lspconfig").opts = {
  servers = {
    volar = {
      init_options = {
        vue = {
          hybridMode = true,
        },
      },
    },
    vtsls = {},
  },
}
