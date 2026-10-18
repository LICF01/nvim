<h1 align="center">Neovim</h1>
<p align="center">Personal Neovim config. The same repo runs on every machine: each one enables the language stacks it needs.</p>

![nvim](https://github.com/LICF01/nvim/assets/41651420/53b6a69a-ceea-416e-b94a-e4977853f486)

## Quick start

```sh
git clone <this repo> ~/.config/nvim
nvim                          # lazy.nvim installs the plugins
cp lua/local.example.lua lua/local.lua   # optional: font and vaults for this machine
```


## Documentation

| Document | Contents |
|---|---|
| [docs/stacks.md](docs/stacks.md) | language stacks: what each one contains, `:Stack` commands, new machines, adding a stack |
| [docs/structure.md](docs/structure.md) | layout, load order, conventions, where state lives |

## Layout

```
init.lua            entry point
lua/core/           keymaps, options, lazy.nvim bootstrap
lua/plugins/        one spec file per feature (lsp/ and dap/ are subfolders)
lua/utils/          language stacks and per-machine settings
lua/local.example.lua   template for lua/local.lua (git-ignored)
docs/               documentation
```

## Per-machine setup

Two things differ per machine, and neither is committed:

- **Language stacks**, saved in `~/.local/share/nvim/lang-stacks.json`. Set them with `:Stack`.
- **Settings** such as the GUI font and Obsidian vaults, in `lua/local.lua`.
  Copy `lua/local.example.lua` and edit it.

See [docs/stacks.md#new-machine](docs/stacks.md#new-machine) for the full steps.
