local M = {}

M.completion = {
	class = "󰠱",
	color = "󰏘",
	constant = "󰏿",
	constructor = "",
	enum = "",
	enum_member = "",
	event = "",
	field = "󰜢",
	file = "󰈔",
	folder = "󰉋",
	function_ = "󰊕",
	interface = "",
	keyword = "󰌋",
	method = "󰆧",
	module = "󰏗",
	operator = "󰆕",
	property = "󰜢",
	reference = "󰈇",
	snippet = "󰘍",
	struct = "󰙅",
	text = "󰉿",
	type_parameter = "󰊄",
	unit = "󰑭",
	value = "󰎠",
	variable = "󰂡",
}

M.dashboard = {
	config = "",
	find_file = "",
	find_text = "",
	lazy = "󰒲",
	new_file = "",
	quit = "",
	recent_files = "",
	restore_session = "",
}

M.dev = {
	docker = "󰡨",
	nextjs = "󰇄",
	nodejs = "󰎙",
	package = "󰏗",
	react = "󰞺",
	tailwind = "󱏿",
	test = "󰙨",
}

M.diagnostics = {
	diagnostic = "󰒡",
	error = "",
	hint = "",
	info = "",
	trace = "",
	warn = "",
}

M.editing = {
	comment = "󰅺",
	delete = "󰆴",
	delete_line = "",
	format = "󰒓",
	insert = "󰦪",
	pair = "󰆴",
	pencil = "󰑕",
	replace = "󰛔",
	select = "󰒅",
	tag = "󰗀",
}

M.filetypes = {
	css = "󰌜",
	html = "󰌝",
	javascript = "󰌞",
	json = "󰘦",
	jsx = "󰜈",
	lua = "󰢱",
	markdown = "󰍔",
	shell = "󰆍",
	tsx = "󰛦",
	typescript = "󰛦",
	yaml = "󰰂",
}

M.general = {
	buffer = "",
	bug = "",
	clear = "󰅶",
	clipboard = "󰅍",
	clipboardcopy = "󱉥",
	close = "󰈆",
	close_buffer = "󰅗",
	command = "󰘳",
	disable = "󱎭",
	exit = "󰌑",
	files = "󰈔",
	filter = "",
	find = "",
	find_file = "󰱼",
	help = "󰋖",
	keymap = "󰌌",
	mode = "󰀘",
	readonly = "󰌾",
	recent = "󰋚",
	save = "󰆓",
	search = "",
	selection = "󰘥",
	settings = "󰒓",
	terminal = "󰆍",
	ui = "",
}

M.git = {
	add = "",
	blame = "󰊢",
	branch = "",
	change = "",
	conflict = "",
	delete = "",
	git = "󰊢",
	ignored = "",
	rename = "󰁕",
	staged = "",
	topdelete = "󰍵",
	unstaged = "󰄱",
	untracked = "",
}

M.lsp = {
	code_action = "󰌵",
	definition = "󰒕",
	formatting = "󰉢",
	hover = "󰞋",
	implementation = "󰡱",
	references = "󰈇",
	rename = "󰑕",
	server = "󰒓",
}

M.mason = {
	package_installed = "",
	package_pending = "",
	package_uninstalled = "",
}

M.navigation = {
	buffer = "󰓩",
	explorer = "",
	explorer_focus = "󱞊",
	file = "󰈔",
	folder = "󰉋",
	folder_empty = "󰉖",
	folder_open = "󰝰",
	search = "󰇉",
	source = "󰒓",
}

M.ui = {
	expand_collapsed = "",
	expand_expanded = "",
	group = "󰙅",
	horizontal = "─",
	horizontal_thin = "╌",
	rounded_bottom_left = "╰",
	rounded_bottom_right = "╯",
	rounded_left = "╭",
	rounded_right = "╮",
	selection = "",
	separator = "│",
	split = "󱤗",
	vertical_bar = "│",
	vertical_bar_thin = "▏",
}

M.whichkey = {
	buffer = "",
	code = "",
	git = "",
	lsp = "󰰌",
	search = "",
	split = "󰯌",
	terminal = "",
	ui = "",
}

return M
