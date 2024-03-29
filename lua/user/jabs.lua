local status_ok, jabs = pcall(require, "jabs")
if not status_ok then
	return
end

jabs.setup {
	-- Options for the main window
	position = 'corner', -- center, corner. Default corner
	width = 80, -- default 50
	height = 20, -- default 10
	border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars). Default shadow

	offset = { -- window position offset
		top = 2, -- default 0
		bottom = 2, -- default 0
		left = 2, -- default 0
		right = 2, -- default 0
	},

	-- Options for preview window
	preview_position = 'top', -- top, bottom, left, right. Default top
	preview = {
		-- 	width = 30, -- default 70
		-- 	height = 15, -- default 30
		border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars). Default double
	},

	-- Default highlights (must be a valid :highlight)
	highlight = {
		current = "Title", -- default StatusLine
		hidden = "StatusLineNC", -- default ModeMsg
		split = "WarningMsg", -- default StatusLine
		alternate = "StatusLine" -- default WarningMsg
	},

	-- Default symbols
	-- symbols = {
	-- 	current = "C", -- default 
	-- 	split = "S", -- default 
	-- 	alternate = "A", -- default 
	-- 	hidden = "H", -- default ﬘
	-- 	locked = "L", -- default 
	-- 	ro = "R", -- default 
	-- 	edited = "E", -- default 
	-- 	terminal = "T", -- default 
	-- 	default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
	-- },

	-- Keymaps
	keymap = {
		close = "d", -- Close buffer. Default D
		jump = "<space>", -- Jump to buffer. Default <cr>
		h_split = "h", -- Horizontally split buffer. Default s
		v_split = "v", -- Vertically split buffer. Default v
		preview = "p", -- Open buffer preview. Default P
	},

	-- Whether to use nvim-web-devicons next to filenames
	use_devicons = true -- true or false. Default true
}
