return {

	["jpalardy/vim-slime"] = {
		--ft = {"jl", "py", "m"},
		config = function()
			vim.g.slime_paste_file = "$HOME/.cache/slime_paste"
			vim.g.slime_target = "tmux"
			vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
			vim.g.slime_cell_delimiter = "\n"
			require("custom.mappings").vim_slime()
		end,
	},

	["JuliaEditorSupport/julia-vim"] = {
		-- lazy load does not work
		-- https://github.com/JuliaEditorSupport/julia-vim/issues/269
		-- ft = {"jl"},
	},

	["christoomey/vim-tmux-navigator"] = {
		--ft = {"jl", "py", "m"},
		config = function()
			--require("custom.mappings").vim_tmux_navigator()
		end,
	},

	["lervag/vimtex"] = {
		ft = {"tex"},
		setup = function()
			-- possibly move out of lazy load
			vim.g.vimtex_view_method = "zathura"
		end,
	},

	["xuhdev/vim-latex-live-preview"] = {
		ft = {"tex"},
		config = function()
			print("latex-preview config")
			vim.g.livepreview_use_biber = 1
			vim.g.livepreview_cursorhold_recompile = 1
			vim.opt.updatetime = 1000
			require("custom.mappings").vim_latex_live_preview()
		end,
	},

	["vimwiki/vimwiki"] = {
		config = function()
			vim.g.vimwiki_ext2syntax = { ['.Rmd']='markdown', ['.rmd']='markdown', ['.md']='markdown', ['.markdown']='markdown', ['.mdown']='markdown' }
			--require("custom.plugins.mappings").vimwiki()
			--local map = require("core.utils").map
			--map("n", "<leader>ww", ':VimwikiIndex')
			local HOME = os.getenv("HOME")
			vim.g.vimwiki_list = {{ path = HOME .. '/sync/vimwiki', syntax = 'markdown', ext = '.md' }}
		end,
	},
}
