return {
	"echasnovski/mini.icons",
	lazy = true,
	
	opts = {
		-- The default options are excellent, but you can override specific 
		-- file/extension icons or colors here in the future if you want.
	},
	
	specs = {
		-- This is the first magic trick: it tells Lazy.nvim to completely ignore 
		-- any other plugin's request to download or install nvim-web-devicons.
		{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
	},
	
	init = function()
		-- This is the second magic trick: package.preload intercepts any other 
		-- plugin trying to `require("nvim-web-devicons")` and seamlessly redirects 
		-- it to use mini.icons instead.
		package.preload["nvim-web-devicons"] = function()
			require("mini.icons").mock_nvim_web_devicons()
			return package.loaded["nvim-web-devicons"]
		end
	end,
}
