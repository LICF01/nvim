# Language stacks

A **stack** groups what one language needs: treesitter parsers, LSP servers, mason tools,
formatters and linters, and DAP adapters. Each machine enables the stacks it needs, so a work
laptop can have web tooling and a personal laptop can have Rust and Go, from the same repo.

The enabled set is stored per machine in `~/.local/share/nvim/lang-stacks.json`. It is not in
the repo. `core` is always enabled.

## Stacks

| Stack | LSP servers | Mason tools | DAP adapters | Formatters | Linters |
|---|---|---|---|---|---|
| `core` | lua_ls, marksman | stylua, markdownlint-cli2, markdown-toc | | stylua | markdownlint-cli2 |
| `web` | html, cssls, vtsls, tailwindcss, emmet_language_server, astro | prettierd, eslint_d, js-debug-adapter | js, firefox | prettierd, prettier | eslint_d, biomejs |
| `rust` | rust_analyzer | codelldb | codelldb | rustfmt | |
| `go` | gopls | | delve | gofmt | |
| `python` | pyright | ruff | python | ruff_format | |
| `sql` | sqls | sqlfmt | | sqlfmt | |
| `kotlin` | kotlin_language_server | | | | |

Treesitter parsers, from the same definitions:

- `core`: bash, dockerfile, gitignore, json, lua, luadoc, make, markdown, markdown_inline, query,
  regex, toml, vim, vimdoc, yaml
- `web`: astro, css, html, javascript, jsdoc, scss, tsx, typescript
- `rust`: rust, toml, ron
- `go`: go, gomod, gowork, gosum
- `python`: python
- `sql`: sql, csv
- `kotlin`: kotlin

`rustfmt` and `gofmt` come from the Rust and Go toolchains, not from mason, so the stacks don't
install them. They're listed under formatters so they're enabled and disabled with their stack.

## Commands

| Command | What it does |
|---|---|
| `:Stack` | Shows the status, the same as `:Stack status`. |
| `:Stack install <stack>` | Enables the stack and installs its packages and parsers. |
| `:Stack enable <stack>` | Enables the stack. It takes effect on restart, and installs nothing. |
| `:Stack disable <stack>` | Disables the stack. It takes effect on restart; installed packages stay. |
| `:Stack uninstall <stack>` | Removes packages and parsers that no remaining stack needs, then disables the stack. |
| `:Stack uninstall all` | Uninstalls every stack except `core`. |
| `:Stack prune` | Lists installed packages and parsers that no enabled stack owns, and removes them after you confirm. |
| `:Stack status` | Shows the enabled stacks and, for each one, what is still missing. `:Stack list` is the same. |

Tab completion works for the subcommands and stack names.

### What happens at startup

- Missing LSP servers, DAP adapters and treesitter parsers for the enabled stacks are installed
  automatically in the background.
- Formatter and linter tools are **not** installed at startup. `:Stack install` installs them.
  If a formatter is missing, formatting for that filetype doesn't work until you run `:Stack install`.

## New machine

1. Clone the repo into `~/.config/nvim` and start Neovim. lazy.nvim installs the plugins.
2. Copy the per-machine template and edit it: `cp lua/local.example.lua lua/local.lua`.
3. Choose the stacks with `:Stack install <stack>`.
4. Run `:Stack status` until nothing is listed as missing. Installs run in the background.

Example:

- Work laptop: `:Stack install web`
- Personal laptop: `:Stack install rust`, then `:Stack install go`

## Behaviour to know about

- **Enabling is not installing.** `:Stack enable` only turns on the editor integrations. If the
  servers aren't installed, they fail when you open a matching file. Use `install` on new machines.
- **State is read once per session** and cached. If you edit `lang-stacks.json` by hand, restart
  Neovim.

## Adding a stack

1. **Define the group** in `lua/utils/lang-stacks.lua`, in `M.groups`:
   `desc`, `treesitter`, `lsp`, `tools`, `dap`, `formatters`, `linters`.
   Use `{}` for the lists that don't apply.
2. **Add an LSP config** for each server in the `specs` table in `lua/plugins/lsp/lspconfig.lua`.
   A server listed in `lsp` but missing from `specs` never starts.
3. **Map the mason package** if its name differs from the server name, in `lsp_to_package`
   (`lua/utils/lang-stacks.lua`). Do the same for DAP adapters in `dap_to_package`.
4. **Add formatter and linter entries** to the filetype maps in `lua/plugins/formatting.lua`
   and `lua/plugins/linting.lua`. Names must match the conform or nvim-lint built-ins. Then list
   the same names in the group's `formatters` and `linters`. An entry that no enabled stack
   lists is never used.
5. **Optional DAP config.** A file at `lua/plugins/dap/configs/<group>.lua` runs only while the
   stack is enabled. `web.lua` is an example.
6. **Check it:** `:Stack status` should list the new stack. `:Stack install <group>` on a test
   machine installs its packages.
