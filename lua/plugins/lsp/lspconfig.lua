return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- { "artemave/workspace-diagnostics.nvim" },
	},
	opts = {},
	config = function()
		local lsp = vim.lsp

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Go to declaration"
			keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>cA", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
			keymap.set("n", "<leader>ch", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			keymap.set("n", "<leader>cxf", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			-- -- some clients support workspace diagnostics natively
			-- if client:supports_method("workspace/diagnostic", bufnr) then
			-- 	vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
			-- else
			-- 	require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			-- end
		end

		-- Completion capabilities from blink.cmp are merged into every server's
		-- initialize request, when the server starts. Reading them here instead
		-- would load blink.cmp (and LuaSnip, friendly-snippets) on every file open.
		vim.lsp.config("*", {
			before_init = function(params)
				local blink_cmp = require("blink.cmp")
				params.capabilities = vim.tbl_deep_extend("force", params.capabilities or {}, blink_cmp.get_lsp_capabilities())
				params.capabilities.textDocument.completion.completionItem.snippetSupport = true
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		local severity = vim.diagnostic.severity
		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = signs.Error,
					[severity.WARN] = signs.Warn,
					[severity.HINT] = signs.Hint,
					[severity.INFO] = signs.Info,
				},
			},
		})

		-- Only configure servers whose stack is enabled on this machine
		-- (:Stack install rust / web ...). Disabled stacks are skipped AND
		-- explicitly disabled so they never attach.
		local stacks = require("utils.lang-stacks")

		local specs = {
			-- configure html server
			html = {
				on_attach = on_attach,
				filetypes = { "html", "ejs" },
			},

			-- Don't use tsserver if you are using typescript-tools.nvim
			-- configure typescript server with plugin
			-- ts_ls = {
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- },

			vtsls = {
				on_attach = on_attach,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							maxInlayHintLength = 40,
							completion = {
								enableServerSideFuzzyMatch = true,
								entriesLimit = 100, -- Critical: prevents lag
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false }, -- disabled for performance
						},
					},
				},
			},

			-- tsgo = {
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- },

			tailwindcss = {
				on_attach = on_attach,
			},

			-- configure css server
			cssls = {
				on_attach = on_attach,
			},

			-- configure emmet language server
			emmet_language_server = {
				on_attach = on_attach,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"astro",
					"ejs",
				},
			},

			-- configure python server
			pyright = {
				on_attach = on_attach,
			},

			-- configure astro server
			astro = {
				on_attach = on_attach,
			},

			kotlin_language_server = {
				on_attach = on_attach,
			},

			marksman = {
				on_attach = on_attach,
			},

			sqls = {
				on_attach = on_attach,
			},

			gopls = {
				on_attach = on_attach,
			},

			rust_analyzer = {
				on_attach = on_attach,
			},

			-- configure lua server (with special settings)
			lua_ls = {
				on_attach = on_attach,
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths
								-- here.
								-- '${3rd}/luv/library'
								-- '${3rd}/busted/library'
							},
							-- Or pull in all of 'runtimepath'.
							-- NOTE: this is a lot slower and will cause issues when working on
							-- your own configuration.
							-- See https://github.com/neovim/nvim-lspconfig/issues/3189
							-- library = {
							--   vim.api.nvim_get_runtime_file('', true),
							-- }
						},
					})
				end,
				settings = {
					Lua = {},
				},
			},
		}

		for name, cfg in pairs(specs) do
			if stacks.lsp_enabled(name) then
				lsp.config(name, cfg)
				pcall(vim.lsp.enable, name, true)
			else
				-- make sure a previously-enabled server stays off
				pcall(vim.lsp.enable, name, false)
			end
		end
	end,
}
