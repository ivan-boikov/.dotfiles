-- This is an example chadrc file , its supposed to be placed in /lua/custom/

local M = {}

local override = require "custom.plugins.override"
local userPlugins = require "custom.plugins"

M.plugins = {

	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},

		statusline = {
			separator_style = "round",
		},
	},

	override = {
		["kyazdani42/nvim-tree.lua"] = override.nvimtree,
		["nvim-treesitter/nvim-treesitter"] = override.treesitter,
		["nvim-telescope/telescope.nvim"] = override.telescope,
	},

	-- I forked this repo for my own snippets
	remove = {
		"rafamadriz/friendly-snippets",
	},

	user = userPlugins,
}


-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
	theme = "onedark",
}

M.mappings = require "custom.mappings"

return M
