# Structure

How the config is laid out, what loads when, and where state lives.

## Layout

```
init.lua                  entry point: keymaps, options, then lazy.nvim
lua/
  core/
    keymaps.lua           leader key and global keymaps (no plugins needed)
    options.lua           vim.opt settings, shell fallback, Makefile tabs
    lazy.lua              bootstraps lazy.nvim and imports the plugin specs
  plugins/                one spec file per feature
    lsp/                  lspconfig (servers, buffer keymaps) and mason
    dap/                  nvim-dap and dap/configs/<stack>.lua
  utils/
    lang-stacks.lua       language stacks: groups, state, :Stack command
    machine.lua           reads lua/local.lua (git-ignored)
  local.example.lua       template for per-machine settings
lazy-lock.json            pinned plugin versions
docs/                     this documentation
```

## Load order

1. `init.lua` requires `core.keymaps`, `core.options`, then `core.lazy`.
   The leader key is set to `<Space>` in `keymaps.lua`, before any plugin loads.
2. `core.lazy` clones lazy.nvim into `stdpath("data")/lazy` if it is missing, then imports
   `plugins`, `plugins/lsp` and `plugins/dap`. The update checker is enabled.
3. Plugins with `lazy = false` load at startup: `snacks.nvim`, `tokyonight`, `mason.nvim`,
   `aerial.nvim`, `contextindent.nvim`, `vim-sleuth`, `nvim-web-devicons`. `contextindent.nvim`
   also pulls in nvim-treesitter.
4. Everything else loads on its trigger: an event (`BufReadPre`, `InsertEnter`, `VeryLazy`),
   a command, a filetype, or the first press of one of its keys. Use `:Lazy` to see them all.

Startup installs nothing. An enabled stack only registers its LSP servers, and one notice lists
anything still missing (see [stacks.md](stacks.md)).

## Conventions

- **One feature per spec file.** Keys go in the spec's `keys` table, so lazy.nvim can load the
  plugin on first use. Every mapping gets a `desc`, which is what which-key and the picker show.
- **Language-specific data lives in `lua/utils/lang-stacks.lua`.** Other files read from it
  instead of hardcoding tool lists. See [stacks.md](stacks.md#adding-a-stack).
- **Machine-specific values go in `lua/local.lua`**, which is git-ignored. Start from
  `lua/local.example.lua`.
## Where state lives

Nothing machine-specific is committed. The paths below are outside the repo.

| What | Path | Notes |
|---|---|---|
| Plugins | `~/.local/share/nvim/lazy` | managed by lazy.nvim |
| LSP servers, DAP adapters, formatters | `~/.local/share/nvim/mason` | managed by mason |
| Treesitter parsers | `~/.local/share/nvim/site/parser` | managed by nvim-treesitter |
| Enabled stacks | `~/.local/share/nvim/lang-stacks.json` | `{"version":1,"enabled":[...]}` |
| Per-machine settings | `lua/local.lua` (in the repo, git-ignored) | copied from `lua/local.example.lua` |

Plugin versions are pinned in `lazy-lock.json`, which is tracked. Update it with `:Lazy update`
and commit the result.
