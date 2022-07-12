local M = {}

M.general = {
	n = {
		-- check file in shellcheck
		["<leader>s"] = {":!clear && shellcheck -x %<CR>", ""},
		-- open bibliography file in split
		["<leader>b"] = {":vsp<space>$BIB<CR>", ""},
		["<leader>r"] = {":vsp<space>$REFER<CR>", ""},
		--  compile document, be it groff/LaTeX/markdown/etc.
		["<leader>lc"] = {":w! | !compile '<c-r>%'<CR>", ""},
		-- open corresponding .pdf/.html or preview
		["<leader>lp"] = {":!opout <c-r>%<CR><CR>", ""},
		["<leader>pc"] = {":PackerCompile <CR>", ""},
		["<F5>"] = {":make run<CR>", ""},
		["<F7>"] = {":make<CR>", ""},
		--[""] = {"", ""},
	}
}

M.vim_latex_live_preview = {
    n = {
        ["<F5>"] = {":LLPStartPreview<CR>", ""},
    },
}

M.vim_slime = {
	v = {
		["<C-c><C-c>"] = {"<Plug>SlimeRegionSend", ""},
	},
	n = {
		["<C-c><C-c>"] = {"<Plug>SlimeParagraphSend", ""},
		["<C-c>v"] = {"<Plug>SlimeConfig", ""},
	}
}

M.vim_tmux_navigator = {
	n = {
		["<C-l>"] = {":TmuxNavigateRight<CR>", ""},
	},
}

--M.vimwiki = {
--    n = {
--        ["<leader>wf"] = {"<cmd> VimwikiIndex <CR>", ""},
--    }
--}

-- replace all is aliased to S.
-- vimscript prints immediately that I entered search-replace mode, lua does not
-- map("n", "S", ":%s//g<Left><Left>")
vim.cmd("nnoremap S :%s//g<Left><Left>")

return M
