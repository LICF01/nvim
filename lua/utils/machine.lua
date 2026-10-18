-- Per-machine settings from lua/local.lua. That file is git-ignored; copy
-- lua/local.example.lua to it and edit it for this machine.
-- A missing file means no overrides. A broken one is reported, not fatal.
local ok, cfg = pcall(require, "local")
if ok then
	return type(cfg) == "table" and cfg or {}
end

if not tostring(cfg):find("module 'local' not found", 1, true) then
	vim.schedule(function()
		vim.notify("lua/local.lua: " .. tostring(cfg), vim.log.levels.ERROR)
	end)
end
return {}
