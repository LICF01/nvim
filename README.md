<h1 align="center">Neovim</h1>
<p align="center">Personal Neovim config, kept in git so the same setup can be installed on any machine.</p>

![nvim](https://github.com/LICF01/nvim/assets/41651420/53b6a69a-ceea-416e-b94a-e4977853f486)

## Quick start

```sh
git clone <this repo> ~/.config/nvim
nvim                                      # lazy.nvim installs the plugins on first start
cp lua/local.example.lua lua/local.lua    # optional: font and Obsidian vaults for this machine
```

## Structure

```
init.lua                entry point: keymaps, options, then lazy.nvim
lua/core/               keymaps, options, lazy.nvim bootstrap
lua/plugins/            one spec file per feature (lsp/ and dap/ are subfolders)
lua/utils/              language stacks and per-machine settings
lua/local.example.lua   template for lua/local.lua (git-ignored)
docs/                   documentation
```

Plugins are loaded in the order `core` → `plugins` → `plugins/lsp` → `plugins/dap`. Most of them
load on demand, on an event, a command, a filetype or their first key. The details are in
[docs/structure.md](docs/structure.md).

## Plugins

About 70 plugins, including their dependencies. They cover completion, LSP, formatting and linting,
treesitter, the UI, git, debugging, tests and Obsidian notes. 

## Keymaps

The leader key is `<Space>`. Press it and wait, and which-key lists what comes next. 

## Optional: language stacks

A stack is a set of tools for one language: treesitter parsers, LSP servers, formatters, linters and
debug adapters. This is optional. Only `core` (the config language and markdown) is always on; every other stack is
your choice. Use it only if you want a different set of tools on each machine. Stacks are saved per machine in
`~/.local/share/nvim/lang-stacks.json`, which is not in the repo.

- `:Stack status` shows what is still missing.
- Nothing installs at startup. Packages install only through `:Stack install <stack>`.

See [docs/stacks.md](docs/stacks.md) for the stacks, the commands and how to add one.

## Per-machine settings

Settings that differ between machines, such as the GUI font and the Obsidian vaults, go in
`lua/local.lua`. That file is git-ignored. Copy `lua/local.example.lua` and edit it. A missing file
keeps the defaults.

## Documentation

| Document | Contents |
|---|---|
| [docs/structure.md](docs/structure.md) | layout, load order, conventions, where state lives |
| [docs/stacks.md](docs/stacks.md) | language stacks: contents, `:Stack` commands, new machines, adding a stack |
