local M = {}

local defaults = {
	dark = nil,
	light = nil,
}

--- Detect system theme (dark/light)
--- @return "dark" | "light"
local function detect_system_theme()
	local sys = vim.loop.os_uname().sysname
	local result = ""

	if sys == "Darwin" then
		local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
		result = handle:read("*a")
		handle:close()
		result = result and result:gsub("%s+", "") or ""
		return (result == "Dark") and "dark" or "light"
	elseif sys == "Linux" then
		local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
		result = handle:read("*a")
		handle:close()
		if result:match("dark") then
			return "dark"
		else
			return "light"
		end
	elseif sys:match("Windows") then
		local handle = io.popen(
			[[reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme]]
		)
		result = handle:read("*a")
		handle:close()
		if result:match("0x0") then
			return "dark"
		else
			return "light"
		end
	end

	return "light"
end

--- Setup system theme detection
--- @param opts? {dark?: string, light?: string}
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", defaults, opts or {})

	local theme = detect_system_theme()
	vim.opt.background = theme

	-- Only set colorscheme if explicitly provided
	if theme == "dark" and opts.dark then
		vim.cmd.colorscheme(opts.dark)
	elseif theme == "light" and opts.light then
		vim.cmd.colorscheme(opts.light)
	end
end

return M
