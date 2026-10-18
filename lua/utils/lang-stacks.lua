-- Central definition of language stacks ("groups").
-- One `:Stack` command installs/uninstalls/enables/disables a whole stack:
-- treesitter parsers + mason packages + LSP + formatters/linters + DAP.
-- Enabled stacks persist per-machine in stdpath("data")/lang-stacks.json,
-- so your personal and work computers can enable different stacks without
-- editing (or commenting out) config.
--
-- Ownership: a formatter or linter (conform / nvim-lint name) is active only
-- when an enabled stack lists it in `formatters` / `linters`. The filetype
-- maps themselves live in plugins/formatting.lua and plugins/linting.lua.
local M = {}

local STATE_VERSION = 1
-- Always enabled, whatever the state file says.
local ALWAYS_ON = "core"

-- stylua: ignorestart
M.groups = {
	core = {
		desc = "Always-on basics (config language, markdown, data files)",
		treesitter = {
			"bash",
			"dockerfile",
			"gitignore",
			"json",
			"lua",
			"luadoc",
			"make",
			"markdown",
			"markdown_inline",
			"query",
			"regex",
			"toml",
			"vim",
			"vimdoc",
			"yaml",
		},
		lsp = { "lua_ls", "marksman" },
		tools = { "stylua", "markdownlint-cli2", "markdown-toc" },
		dap = {},
		formatters = { "stylua" },
		linters = { "markdownlint-cli2" },
	},
	web = {
		desc = "React / TypeScript / Astro",
		treesitter = {
			"astro",
			"css",
			"html",
			"javascript",
			"jsdoc",
			"scss",
			"tsx",
			"typescript",
		},
		lsp = {
			"html",
			"cssls",
			"vtsls",
			"tailwindcss",
			"emmet_language_server",
			"astro",
		},
		tools = { "prettierd", "eslint_d", "js-debug-adapter" },
		dap = { "js", "firefox" },
		formatters = { "prettierd", "prettier" },
		linters = { "eslint_d", "biomejs" },
	},
	rust = {
		desc = "Rust",
		treesitter = { "rust", "toml", "ron" },
		-- rustfmt comes via rustup (conform uses it with lsp fallback);
		-- codelldb provides debugging via mason.
		lsp = { "rust_analyzer" },
		tools = { "codelldb" },
		dap = { "codelldb" },
		formatters = { "rustfmt" },
	},
	go = {
		desc = "Go",
		treesitter = { "go", "gomod", "gowork", "gosum" },
		lsp = { "gopls" },
		tools = {},
		dap = { "delve" },
		formatters = { "gofmt" },
	},
	python = {
		desc = "Python",
		treesitter = { "python" },
		lsp = { "pyright" },
		tools = { "ruff" },
		dap = { "python" },
		formatters = { "ruff_format" },
	},
	sql = {
		desc = "SQL / data",
		treesitter = { "sql", "csv" },
		lsp = { "sqls" },
		tools = { "sqlfmt" },
		dap = {},
		formatters = { "sqlfmt" },
	},
	kotlin = {
		desc = "Kotlin",
		treesitter = { "kotlin" },
		lsp = { "kotlin_language_server" },
		tools = {},
		dap = {},
	},
}
-- stylua: ignoreend

M.defaults = { "core" }

function M.state_path()
	return vim.fs.joinpath(vim.fn.stdpath("data"), "lang-stacks.json")
end

function M.list_groups()
	local keys = vim.tbl_keys(M.groups)
	table.sort(keys)
	return keys
end

-- Memoized enabled list. Reset by set_enabled().
local cache

-- State file formats: version 1 is {"version":1,"enabled":[...]}; the
-- unversioned format was a bare array of group names and is still read.
local function read_state()
	local f = io.open(M.state_path(), "r")
	if not f then
		return nil
	end
	local raw = f:read("*a")
	f:close()
	local ok, decoded = pcall(vim.json.decode, raw)
	if not ok or type(decoded) ~= "table" then
		return nil
	end
	if vim.islist(decoded) then
		return decoded
	end
	return decoded.enabled
end

function M.get_enabled()
	if not cache then
		local list = read_state()
		if type(list) ~= "table" then
			list = {}
		end
		local valid = {}
		for _, g in ipairs(list) do
			if M.groups[g] and not vim.tbl_contains(valid, g) then
				valid[#valid + 1] = g
			end
		end
		if not vim.tbl_contains(valid, ALWAYS_ON) then
			table.insert(valid, 1, ALWAYS_ON)
		end
		cache = valid
	end
	return vim.deepcopy(cache)
end

function M.set_enabled(groups)
	local valid = {}
	for _, g in ipairs(groups) do
		if M.groups[g] then
			if not vim.tbl_contains(valid, g) then
				valid[#valid + 1] = g
			end
		else
			vim.notify("Stack: unknown group: " .. g, vim.log.levels.WARN)
		end
	end
	if not vim.tbl_contains(valid, ALWAYS_ON) then
		valid[#valid + 1] = ALWAYS_ON
	end
	table.sort(valid)
	local path = M.state_path()
	vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
	local f = io.open(path, "w")
	if f then
		f:write(vim.json.encode({ version = STATE_VERSION, enabled = valid }))
		f:close()
	else
		vim.notify("Stack: could not write " .. path, vim.log.levels.ERROR)
	end
	cache = nil
	return valid
end

function M.is_enabled(group)
	return vim.tbl_contains(M.get_enabled(), group)
end

-- Which group(s) own an LSP server? Used to gate lspconfig + uninstall.
function M.lsp_owner(server)
	local owners = {}
	for name, g in pairs(M.groups) do
		if vim.tbl_contains(g.lsp or {}, server) then
			owners[#owners + 1] = name
		end
	end
	return owners
end

function M.lsp_enabled(server)
	for _, owner in ipairs(M.lsp_owner(server)) do
		if M.is_enabled(owner) then
			return true
		end
	end
	return false
end

-- mason-nvim-dap wants nvim-dap adapter names ("js", "firefox", ...),
-- mason-registry wants package names ("js-debug-adapter", ...).
M.dap_to_package = {
	js = "js-debug-adapter",
	firefox = "firefox-debug-adapter",
	delve = "delve",
	codelldb = "codelldb",
	python = "debugpy",
}

-- mason-registry wants mason package names ("css-lsp", "html-lsp", ...),
-- but groups store lspconfig server names ("cssls", "html", ...).
M.lsp_to_package = {
	lua_ls = "lua-language-server",
	marksman = "marksman",
	html = "html-lsp",
	cssls = "css-lsp",
	vtsls = "vtsls",
	tailwindcss = "tailwindcss-language-server",
	emmet_language_server = "emmet-language-server",
	astro = "astro-language-server",
	rust_analyzer = "rust-analyzer",
	gopls = "gopls",
	pyright = "pyright",
	sqls = "sqls",
	kotlin_language_server = "kotlin-language-server",
}

-- Mason package names for the LSP servers of the given groups.
function M.lsp_packages(groups)
	local out = {}
	local seen = {}
	for _, server in ipairs(M.collect("lsp", groups)) do
		local pkg = M.lsp_to_package[server] or server
		if not seen[pkg] then
			seen[pkg] = true
			out[#out + 1] = pkg
		end
	end
	return out
end

-- All mason package names owned by the given groups (defaults to enabled).
function M.owned_packages(groups)
	local out = {}
	local seen = {}
	local function add(list)
		for _, v in ipairs(list) do
			if not seen[v] then
				seen[v] = true
				out[#out + 1] = v
			end
		end
	end
	add(M.lsp_packages(groups))
	add(M.collect("tools", groups))
	add(M.dap_packages(groups))
	return out
end

function M.dap_packages(groups)
	local out = {}
	local seen = {}
	for _, adapter in ipairs(M.collect("dap", groups)) do
		local pkg = M.dap_to_package[adapter] or adapter
		if not seen[pkg] then
			seen[pkg] = true
			out[#out + 1] = pkg
		end
	end
	return out
end

-- Collect a deduplicated list of `key` ("treesitter"|"lsp"|"tools"|"dap")
-- across the given groups (defaults to enabled groups).
function M.collect(key, groups)
	local out = {}
	local seen = {}
	for _, gname in ipairs(groups or M.get_enabled()) do
		local g = M.groups[gname]
		if g then
			for _, v in ipairs(g[key] or {}) do
				if not seen[v] then
					seen[v] = true
					out[#out + 1] = v
				end
			end
		end
	end
	return out
end

-- Set of formatter (or linter) names owned by the enabled stacks.
-- `kind` is "formatters" or "linters".
local function active_tools(kind)
	local set = {}
	for _, gname in ipairs(M.get_enabled()) do
		for _, name in ipairs(M.groups[gname][kind] or {}) do
			set[name] = true
		end
	end
	return set
end

-- Keep only the names in a conform / nvim-lint filetype entry that an enabled
-- stack owns. Options such as stop_after_first and lsp_format are kept.
-- Returns nil when nothing is left, so the filetype is dropped.
local function filter_entry(entry, active)
	local out = {}
	local kept = 0
	for k, v in pairs(entry) do
		if type(k) ~= "number" then
			out[k] = v
		end
	end
	for _, name in ipairs(entry) do
		if active[name] then
			kept = kept + 1
			out[kept] = name
		end
	end
	if kept > 0 then
		return out
	end
end

-- Filter a { [ft] = entry } map by tool ownership. `kind` is "formatters"
-- or "linters".
function M.filter_tool_map(full, kind)
	local active = active_tools(kind)
	local out = {}
	for ft, entry in pairs(full) do
		out[ft] = filter_entry(entry, active)
	end
	return out
end

function M.enable(group)
	if not M.groups[group] then
		vim.notify("Stack: unknown group: " .. group, vim.log.levels.WARN)
		return M.get_enabled()
	end
	local enabled = M.get_enabled()
	if not vim.tbl_contains(enabled, group) then
		enabled[#enabled + 1] = group
		enabled = M.set_enabled(enabled)
		vim.notify("Stack: enabled " .. group .. " (takes effect on restart)", vim.log.levels.INFO)
	end
	return enabled
end

function M.disable(group)
	if not M.groups[group] then
		vim.notify("Stack: unknown group: " .. group, vim.log.levels.WARN)
		return M.get_enabled()
	end
	if group == ALWAYS_ON then
		vim.notify("Stack: refusing to disable 'core'", vim.log.levels.WARN)
		return M.get_enabled()
	end
	local enabled = vim.tbl_filter(function(g)
		return g ~= group
	end, M.get_enabled())
	enabled = M.set_enabled(enabled)
	vim.notify("Stack: disabled " .. group .. " (takes effect on restart)", vim.log.levels.INFO)
	return enabled
end

-- mason helpers ------------------------------------------------------------

local function registry()
	local ok, reg = pcall(require, "mason-registry")
	if not ok then
		vim.notify("mason-registry not available", vim.log.levels.ERROR)
		return nil
	end
	return reg
end

function M.mason_install(names)
	local reg = registry()
	if not reg then
		return
	end
	for _, name in ipairs(names) do
		if name and name ~= "" and not reg.is_installed(name) then
			if reg.has_package(name) then
				local p = reg.get_package(name)
				if not p:is_installed() then
					vim.notify("Stack: installing " .. name, vim.log.levels.INFO)
					p:install()
				end
			else
				vim.notify("Stack: mason package not found: " .. name, vim.log.levels.WARN)
			end
		end
	end
end

function M.mason_uninstall(names, still_needed)
	local reg = registry()
	if not reg then
		return
	end
	still_needed = still_needed or {}
	for _, name in ipairs(names) do
		if still_needed[name] then
			goto continue
		end
		if name and name ~= "" and reg.has_package(name) then
			local p = reg.get_package(name)
			if p:is_installed() then
				vim.notify("Stack: uninstalling " .. name, vim.log.levels.INFO)
				local ok, err = pcall(function()
					p:uninstall()
				end)
				if not ok then
					vim.notify("Stack: failed to uninstall " .. name .. ": " .. err, vim.log.levels.ERROR)
				end
			end
		end
		::continue::
	end
end

-- Full stack operations ----------------------------------------------------

-- Install everything for a group (persist enable + mason + treesitter + LSP).
function M.install(group)
	if not M.groups[group] then
		vim.notify("Stack: unknown group: " .. group, vim.log.levels.WARN)
		return
	end
	M.enable(group)
	local g = M.groups[group]
	M.mason_install(M.lsp_packages({ group }))
	M.mason_install(M.collect("tools", { group }))
	M.mason_install(M.dap_packages({ group }))
	-- treesitter parsers
	local ok_ts, ts = pcall(require, "nvim-treesitter")
	if ok_ts then
		local installed = {}
		pcall(function()
			installed = require("nvim-treesitter.config").get_installed()
		end)
		local missing = vim.tbl_filter(function(p)
			return not vim.tbl_contains(installed, p)
		end, g.treesitter or {})
		if #missing > 0 then
			ts.install(missing)
		end
	end
end

-- Uninstall a group: remove binaries/parsers NOT shared with still-enabled
-- groups, then disable its LSP/formatter/linter integrations.
function M.uninstall(group)
	if not M.groups[group] then
		vim.notify("Stack: unknown group: " .. group, vim.log.levels.WARN)
		return
	end
	if group == ALWAYS_ON then
		vim.notify("Stack: refusing to uninstall 'core'", vim.log.levels.WARN)
		return
	end
	local remaining = vim.tbl_filter(function(g)
		return g ~= group
	end, M.get_enabled())
	-- packages still needed by remaining groups (mason package names)
	local needed_pkg = {}
	for _, v in ipairs(M.owned_packages(remaining)) do
		needed_pkg[v] = true
	end
	-- parsers still needed by remaining groups (treesitter lang names)
	local needed_ts = {}
	for _, v in ipairs(M.collect("treesitter", remaining)) do
		needed_ts[v] = true
	end
	local g = M.groups[group]
	M.mason_uninstall(vim.list_extend(M.lsp_packages({ group }), vim.deepcopy(g.tools or {})), needed_pkg)
	M.mason_uninstall(M.dap_packages({ group }), needed_pkg)
	-- treesitter parsers not needed elsewhere
	local ok_ts, ts = pcall(require, "nvim-treesitter")
	if ok_ts then
		local exclusive = vim.tbl_filter(function(p)
			return not needed_ts[p]
		end, g.treesitter or {})
		if #exclusive > 0 then
			ts.uninstall(exclusive)
		end
	end
	M.disable(group)
end

function M.status_lines()
	local enabled = M.get_enabled()
	local lines = { "Enabled stacks: " .. table.concat(enabled, ", ") }
	for _, name in ipairs(M.list_groups()) do
		local g = M.groups[name]
		local mark = vim.tbl_contains(enabled, name) and "[x]" or "[ ]"
		lines[#lines + 1] = string.format(
			"%s %s - %s (parsers:%d lsp:%d tools:%d dap:%d)",
			mark,
			name,
			g.desc or "",
			#(g.treesitter or {}),
			#(g.lsp or {}),
			#(g.tools or {}),
			#(g.dap or {})
		)
	end
	return lines
end

-- Uninstall every enabled stack except core (keeps the essentials).
function M.uninstall_all()
	local enabled = vim.tbl_filter(function(g)
		return g ~= ALWAYS_ON
	end, M.get_enabled())
	if #enabled == 0 then
		vim.notify("Stack: only core is enabled, nothing to uninstall", vim.log.levels.INFO)
		return
	end
	for _, group in ipairs(enabled) do
		M.uninstall(group)
	end
end

-- Remove anything actually installed that no enabled stack owns.
-- Catches legacy packages (e.g. pylsp, pruned graphql/prismals/clangd),
-- previously-failed uninstalls, and orphaned treesitter parsers.
-- Packages you installed manually outside stacks are listed first and
-- only removed after confirmation.
function M.prune()
	local reg = registry()
	if not reg then
		return
	end
	local owned = {}
	for _, v in ipairs(M.owned_packages()) do
		owned[v] = true
	end
	local orphans = vim.tbl_filter(function(name)
		return not owned[name]
	end, reg.get_installed_package_names())
	table.sort(orphans)

	local owned_ts = {}
	for _, v in ipairs(M.collect("treesitter")) do
		owned_ts[v] = true
	end
	local installed_ts = {}
	pcall(function()
		installed_ts = require("nvim-treesitter.config").get_installed()
	end)
	local orphan_ts = vim.tbl_filter(function(lang)
		return not owned_ts[lang]
	end, installed_ts)
	table.sort(orphan_ts)

	if #orphans == 0 and #orphan_ts == 0 then
		vim.notify("Stack: nothing to prune, all installed packages belong to enabled stacks", vim.log.levels.INFO)
		return
	end

	if #orphans > 0 then
		vim.notify("Stack: orphaned mason packages:\n" .. table.concat(orphans, "\n"), vim.log.levels.WARN)
		local choice = vim.fn.confirm("Uninstall these " .. #orphans .. " packages?", "&Yes\n&No", 2)
		if choice == 1 then
			M.mason_uninstall(orphans, {})
		end
	end

	if #orphan_ts > 0 then
		vim.notify("Stack: orphaned treesitter parsers:\n" .. table.concat(orphan_ts, "\n"), vim.log.levels.WARN)
		local choice = vim.fn.confirm("Uninstall these " .. #orphan_ts .. " parsers?", "&Yes\n&No", 2)
		if choice == 1 then
			local ok_ts, ts = pcall(require, "nvim-treesitter")
			if ok_ts then
				ts.uninstall(orphan_ts)
			end
		end
	end
end

-- Single user command: :Stack install|uninstall|enable|disable|list|status <group>
function M.setup_command()
	vim.api.nvim_create_user_command("Stack", function(opts)
		local args = vim.split(opts.args, "%s+", { trimempty = true })
		local action = args[1]
		local target = args[2]
		if action == "install" and target then
			M.install(target)
		elseif action == "uninstall" and target == "all" then
			M.uninstall_all()
		elseif action == "uninstall" and target then
			M.uninstall(target)
		elseif action == "prune" then
			M.prune()
		elseif action == "enable" and target then
			M.enable(target)
		elseif action == "disable" and target then
			M.disable(target)
		elseif action == "list" or action == "status" or action == nil or action == "" then
			vim.notify(table.concat(M.status_lines(), "\n"), vim.log.levels.INFO)
		else
			vim.notify(
				"Usage: :Stack install|uninstall|enable|disable|prune|list <group> (:Stack uninstall all)",
				vim.log.levels.WARN
			)
		end
	end, {
		nargs = "*",
		complete = function(arg_lead, cmdline)
			local parts = vim.split(cmdline, "%s+")
			-- :Stack <action>
			if #parts <= 2 then
				return vim.tbl_filter(function(a)
					return a:find(arg_lead, 1, true) == 1
				end, { "install", "uninstall", "enable", "disable", "prune", "list", "status" })
			end
			-- :Stack <action> <group> (uninstall also accepts "all")
			local groups = M.list_groups()
			if parts[2] == "uninstall" then
				groups[#groups + 1] = "all"
			end
			return vim.tbl_filter(function(g)
				return g:find(arg_lead, 1, true) == 1
			end, groups)
		end,
		desc = "Install/uninstall language stacks (parsers, LSP, tools)",
	})
end

return M
