<h1 align="center">Neovim</h1>
<p align="center">Personal Neovim config, kept in git so the same setup can be installed on any machine.</p>

![nvim](https://github.com/LICF01/nvim/assets/41651420/53b6a69a-ceea-416e-b94a-e4977853f486)

## Quick start

```sh
git clone <this repo> ~/.config/nvim
nvim                                      # lazy.nvim installs the plugins on first start
cp lua/local.example.lua lua/local.lua    # optional: font and Obsidian vaults for this machine
```

## Requirements

| Tool | Why |
|---|---|
| Neovim 0.11 or newer | the config uses `vim.lsp.config` and `winborder` (0.12 is what it's tested on) |
| git | lazy.nvim clones the plugins |
| a C compiler and `tree-sitter-cli` | nvim-treesitter compiles its parsers |
| Node.js | Copilot's language server runs on Node |
| ripgrep (`rg`) | grep and file search in the snacks picker |
| tmux | the sidekick backend and moving between tmux panes |
| a Nerd Font | icons; the default font is JetBrainsMono NFM |

## Structure

```
init.lua                entry point: keymaps, options, then lazy.nvim
lua/core/               keymaps, options, lazy.nvim bootstrap
lua/plugins/            one spec file per feature (lsp/ and dap/ are subfolders)
lua/utils/              language stacks and per-machine settings
lua/local.example.lua   template for lua/local.lua (git-ignored)
docs/                   documentation
```

How the files load, and which plugins load at startup, is in [docs/structure.md](docs/structure.md).

## Plugins

About 70 plugins, including their dependencies, grouped by what they're for:

- **Completion and AI:** blink.cmp, Copilot, sidekick
- **LSP, formatting and linting:** nvim-lspconfig, mason, conform, nvim-lint
- **Editing and treesitter:** nvim-treesitter, mini.nvim, flash, Comment.nvim
- **UI:** snacks, tokyonight, lualine, noice, which-key
- **Git:** gitsigns, neogit, codediff
- **Notes and markdown:** obsidian.nvim, markdown-preview, render-markdown
- **Debugging, tests and databases:** nvim-dap, neotest, vim-dadbod


## Keymaps

The leader key is `<Space>`. These are the ones used most often:

| Keys | Action |
|---|---|
| `<leader><leader>` | switch buffer |
| `<leader>ff` | find files |
| `<leader>/` | grep the project |
| `<leader>fe` | file explorer |
| `<leader>gg` | lazygit |
| `]h` / `[h` | next / previous git hunk |
| `<leader>cd` | go to definition |
| `<leader>cr` | rename (when a language server is attached) |
| `<leader>ca` | code actions |
| `<leader>cf` | format the file or selection |
| `<leader>xa` | all diagnostics |
| `<leader>dc` | start or continue debugging |
| `<leader>sr` | search and replace |
| `jk` | leave insert mode |
| `<C-s>` | save |


## Language stacks

A set of tools I prefer for a particular language: treesitter parsers, LSP servers, formatters, linters and debug adapters.
This is just because I'm too lazy to install everything when I switch machines and/or don't remember which ones I was using before.
Only `core` (the config language and markdown) is always on.
Stacks are saved per machine in `~/.local/share/nvim/lang-stacks.json`, which is not in the repo.

- `:Stack status` shows what is still missing.
- Nothing installs at startup. Packages install only through `:Stack install <stack>`.

See [docs/stacks.md](docs/stacks.md) for the stacks, the commands and how to add one.

## Per-machine settings

Settings that differ between machines or that I change frequently but don't need them to be permanent go in `lua/local.lua`. 
That file is git-ignored. Copy `lua/local.example.lua` and edit it. Every key is optional, and a missing file keeps the defaults:

- `guifont` and `obsidian_workspaces`: the GUI font and the Obsidian vaults.
- `shell` and `colorscheme`: the shell for `:!` and terminals, and the colour scheme.

## Documentation

| Document | Contents |
|---|---|
| [docs/structure.md](docs/structure.md) | layout, load order, conventions, where state lives |
| [docs/stacks.md](docs/stacks.md) | language stacks: contents, `:Stack` commands, new machines, adding a stack |
