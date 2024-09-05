let MINPAC_DIR = "~/.config/nvim/pack/minpac/opt/minpac/"
if empty(glob(MINPAC_DIR . "/autoload/minpac.vim"))
	call system("mkdir -p " . MINPAC_DIR . "&& git clone https://github.com/k-takata/minpac.git " . MINPAC_DIR)
	" packadd minpac
	" call minpac#init()
	" call minpac#add('k-takata/minpac', {'type': 'opt'})
	" call minpac#update()
	echo 'minpac installed, restart nvim'
	finish
endif

packadd minpac
call minpac#init()

command! PackUpdate packadd minpac | source $MYVIMRC | redraw | call minpac#update()
command! PackClean	packadd minpac | source $MYVIMRC | call minpac#clean()

let mapleader = " "

call minpac#add('k-takata/minpac', {'type': 'opt'})

" general improvements
call minpac#add('lukas-reineke/indent-blankline.nvim')
call minpac#add('tpope/vim-characterize') " improvements to <ga>
call minpac#add('tpope/vim-eunuch') " UNIX stuff: :Wall, :Delete, :Remove
call minpac#add('Darazaki/indent-o-matic') " autodetect alignment
call minpac#add('tpope/vim-surround') " <cs"'> inside "Hello" changes to 'Hello'
call minpac#add('nelstrom/vim-visual-star-search') " visual select + <*> = find selected
call minpac#add('godlygeek/tabular') "	:Tabularize /,/r0 = align by , and align right
call minpac#add('luukvbaal/nnn.nvim')
call minpac#add('folke/which-key.nvim')
call minpac#add('roblillack/vim-bufferlist')

" theming
call minpac#add('NLKNguyen/papercolor-theme')
call minpac#add('itchyny/lightline.vim')

" dev
call minpac#add('jpalardy/vim-slime')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('Issafalcon/lsp-overloads.nvim')
call minpac#add('kyazdani42/nvim-web-devicons')
call minpac#add('folke/trouble.nvim')
call minpac#add('hrsh7th/cmp-nvim-lsp')
call minpac#add('hrsh7th/cmp-nvim-lsp-document-symbol')
call minpac#add('hrsh7th/cmp-nvim-lsp-signature-help')
call minpac#add('amarakon/nvim-cmp-buffer-lines')
call minpac#add('tpope/vim-commentary')
call minpac#add('Thyrum/vim-stabs') " tabs for beginning of lines, spaces otherwise
call minpac#add('vim-autoformat/vim-autoformat')

" snippets
call minpac#add('hrsh7th/nvim-cmp')
call minpac#add('kdheepak/cmp-latex-symbols')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/cmp-path')
call minpac#add('hrsh7th/cmp-cmdline')
call minpac#add('hrsh7th/cmp-nvim-lua')
call minpac#add('L3MON4D3/LuaSnip')
call minpac#add('saadparwaiz1/cmp_luasnip')
call minpac#add('ivan-boikov/friendly-snippets')

call minpac#add('lervag/vimtex')
call minpac#add('vimwiki/vimwiki')

call minpac#add('voldikss/vim-translator')

"call minpac#add('')

if empty(glob("~/.config/nvim/pack/minpac/start/friendly-snippets"))
	call minpac#update()
	echo "Wait for packages to install, then restart nvim one last time"
	finish
endif



map <silent> <C-b> :call BufferList()<CR>


"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set termguicolors


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
	if (has("nvim"))
		"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif


syntax on
" change theme based on time of day
" if strftime("%H") >= 7 && strftime("%H") < 20
"   set background=dark
" else
"   set background=dark
" endif
set termguicolors
colorscheme PaperColor
let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ }


" show full path to file in statusbar
if !exists('g:lightline')
  let g:lightline = {}
endif
if !exists('g:lightline.component')
  let g:lightline.component = {}
endif
let g:lightline.component.filename='%F'


"" use 256 colors in terminal
"if !has("gui_running")
"    set t_Co=256
"    set term=screen-256color
"endif

" Indenting
set tabstop=4		" The width of a TAB is set to 4.
					" Still it is a \t. It is just that
					" Vim will interpret it to be having
					" a width of 4.
set shiftwidth=4	" Indents will have a width of 4
set softtabstop=4	" Sets the number of columns for a TAB
set expandtab " spaces to tabs
set shiftround	" Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent	" Copy indent from current line, over to the new line

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on
" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" search
set ignorecase " obligatory before smartcase
set smartcase

set undofile
set undodir=~/.local/state/nvim

" line numbers
set number
set relativenumber

" soft-wrap text (only visually) at the edge of the window:
" optional - will help to visually verify that it's working
set number
set textwidth=0
set wrapmargin=0
set wrap
" optional - breaks by word rather than character
set linebreak
set formatoptions-=t

" show tabs
set list
set listchars=tab:>-
set listchars+=space:·

function TabSpaceToggle()
	if &expandtab
		set shiftwidth=4
		set softtabstop=0
		set noexpandtab
	else
		set shiftwidth=4
		set softtabstop=4
		set expandtab
	endif
	execute('%retab!')
endfunction
nmap <leader>t mz:execute TabSpaceToggle()<CR>'z


nmap <M-Tab> :bnext<CR>
nmap <M-w> :bd<CR>
nmap <S-Tab> :bprev<CR>
nnoremap <leader>a ggVG


" faster scrolling, allegedly
set re=1
set ttyfast
set lazyredraw

" runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Filetype detection
set filetype
" Ensure files are read as what I want:
"autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
"autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff

"autocmd BufRead,BufNewFile *.jl set filetype=julia
"autocmd BufRead,BufNewFile *.jl let g:did_load_filetypes=1
"autocmd BufRead,BufNewFile *.jl let g:do_filetype_lua=0

" save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" automatically delete all trailing whitespace and newlines at end of file on save
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun
fun! TrimTrailingLines()
	let l:save = winsaveview()
	keeppatterns :v/\_s*\S/d
	call winrestview(l:save)
endfun
autocmd BufWritePre * call TrimWhitespace()
autocmd BufWritePre * call TrimTrailingLines()


" turn off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable
if &diff
	highlight! link DiffText MatchParen
endif

" disable autocommenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" autocompile dwmblocks
" vim.cmd("autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & "})

" join vim's and system's clipboards
" unnamed is X11's PRIMARY register, unnamedplus is CLIPBOARD
set clipboard=unnamedplus

" mappings
" search and replace
nnoremap S :%s//g<Left><Left>
" check file in shellcheck
nmap <leader>s :!clear && shellcheck -x %<CR>
" -- open bibliography file in split
nmap <leader>b :vsp<space>$BIB<CR>
nmap <leader>r :vsp<space>$REFER<CR>
" compile document, be it groff/LaTeX/markdown/etc.
"nmap <leader>lc :w! | !compile '<c-r>%'<CR>
" open corresponding .pdf/.html or preview
"nmap <leader>lp :!opout <c-r>%<CR>
" C/C++ dev
nmap <F5> :!make run<CR>
nmap <F7> :make<CR>


vmap <C-c><C-c> :SlimeRegionSend
nmap <C-c><C-c> :SlimeParagraphSend
let g:slime_paste_file = $XDG_CACHE_HOME . "/slime_paste"
let g:slime_target = "tmux"
let g:slime_default_config = { "socket_name" : "default", "target_pane" : "{last}" }
let g:slime_dont_ask_default = 1
let g:slime_cell_delimiter = "\n"
let g:slime_config_defaults = {}

" send script to julia
" send relative path
au FileType julia nmap <M-Enter> :SlimeSend0 "include(\"".fnamemodify(expand("%"), ":~:.")."\")\r"<CR>
" send full path
au FileType julia nmap <M-S-Enter> :SlimeSend0 "include(\"".expand("%")."\")\r"<CR>

" disable automatic mappings
let g:tmux_navigator_no_mappings = 1
" remaping default things to free keys
"nnoremap <C-j> <C-d>
"nnoremap <C-K> <C-U>
" I only use two vertical panels, for more - I have DWM
nnoremap <C-j> :TmuxNavigateLeft<CR>
nnoremap <C-k> :TmuxNavigateRight<CR>



lua << EOF
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = {{
		"c", "lua", "cpp", "bash", "python",
		"git_rebase", "gitattributes", "gitcommit", "gitignore", "git_config",
		"make", "regex", "vim",
		"html", "css", "javascript", "json", "yaml", "markdown"}},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "latex", "julia" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { "latex", "julia" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
		local max_filesize = 16 * 1024 -- 16 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
				end
			end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false
		},
}
EOF

map gq :Autoformat<CR>
" use LSP gq binding for julia
au FileType julia noremap gq gq=
let g:formatters_python=['ruff', 'autopep8', 'yapf', 'black']
let g:formatdef_ruff = '"ruff format -"'


lua << EOF
	require'lspconfig'.julials.setup{}
	require'lspconfig'.pylyzer.setup{}
EOF
nmap <leader>ld :lua vim.lsp.buf.declaration()<CR>
nmap <leader><leader> :lua vim.lsp.buf.hover()<CR>
nmap <leader>ll :lua vim.lsp.util.show_line_diagnostics()<CR>
nmap <leader>lk :lua vim.lsp.buf.signature_help()<CR>
nmap <leader>lr :lua vim.lsp.buf.references()<CR>

let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_method = 'latexmk'

let g:vimtex_compiler_latexmk = {
			\ 'callback' : 1,
			\ 'continuous' : 1,
			\ 'options' : [
			\ '-shell-escape',
			\ '-synctex=1',
			\ '-interaction=nonstopmode',
			\ '-file-line-error'
			\ ],
			\ }

let g:vimwiki_ext2syntax = { '.Rmd': 'markdown', '.rmd': 'markdown', '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown' }
" require("custom.plugins.mappings").vimwiki()
" local map = require("core.utils").map
nmap <leader>ww :VimwikiIndex<CR>
"local HOME = os.getenv("HOME")
let g:vimwiki_list = [{ 'path' : '~/sync/vimwiki', 'syntax' : 'markdown', 'ext' : '.md' }]









set completeopt=menu,menuone,noselect

lua <<EOF
	local luasnip = require("luasnip")
	local cmp = require("cmp")

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},

		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},

		view = {
			entries = "custom", -- can be "custom", "wildmenu" or "native"
		},

		mapping = cmp.mapping.preset.insert(
			{
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				--['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				['<CR>'] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					s = cmp.mapping.confirm({ select = false }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				}),
			}
		),

		sources = cmp.config.sources(
			{
				{
					name = "latex_symbols",
					option = {
						strategy = 0, -- mixed
					},
				},
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'buffer-lines' },
				{ name = 'nvim_lsp' },
				{ name = 'path' },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users
			},
			{{ name = 'buffer' }
			}),
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype(
		'gitcommit',
		{
			sources = cmp.config.sources(
				{
					{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
				},
				{
					{ name = 'buffer' },
				}
			)
		}
	)

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'nvim_lsp_document_symbol' },
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(
			{{ name = 'path' }},
			{{ name = 'cmdline' }}
		)
	})

	-- Set up lspconfig.
	-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	require('lspconfig')['clangd'].setup {
		capabilities = capabilities
	}
	require('lspconfig')['cmake'].setup {
		capabilities = capabilities
	}
	require('lspconfig')['julials'].setup {
	        capabilities = capabilities
	}

	require("luasnip.loaders.from_vscode").lazy_load()
EOF



" nnn browser integration
lua << EOF
	require("nnn").setup()
EOF
nnoremap <C-n> :NnnPicker cmd=nnn -deAU<CR>
nnoremap <C-b> :NnnPicker cmd=nnn -deAU<CR>



let g:julia_blocks = 0
let g:julia_indent_align_import = 0
let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0
let g:julia_set_indentation = 0

let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_keymap = 0
let g:latex_to_unicode_auto = 0
"let g:latex_to_unicode_file_types = ".jl"

hi link juliaComma Comment
hi link juliaParDelim Comment
hi link juliaSemicolon Comment
hi link juliaFunctionCall Function


noremap <C-_> :Commentary<CR>


" learning French with vim-translator!

function! LearnFrenchMode()
	" Echo translation in the cmdline
	nmap <silent> <Leader>t :Translate<CR>
	vmap <silent> <Leader>t :TranslateV<CR>
	" Display translation in a window
	nmap <silent> <Leader>w :TranslateW<CR>
	vmap <silent> <Leader>w :TranslateWV<CR>
	" Translate the text in clipboard
	nmap <silent> <Leader>x :TranslateX<CR>
	" Replace the text with translation
	"nmap <silent> <Leader>e :TranslateR<CR> \| :let g:translator_target_lang='fr'<CR>
	"nmap <silent> <Leader>f :TranslateR<CR> \| :let g:translator_target_lang='en'<CR>

	nmap <silent> <Leader>e <S-y> \| :pu<CR> \| :let g:translator_target_lang='en'<CR> \| <S-v> \| :TranslateR<CR>:sleep 1500m<CR>
	"\| <S-i> \| <Tab> \| <Esc>
	nmap <silent> <Leader>r <S-y> \| :pu<CR> \| :let g:translator_target_lang='fr'<CR> \| <S-v> \| :TranslateR<CR>:sleep 1500m<CR>

	nmap <silent> <Leader>f 0<Leader>eI<Tab><esc><Esc><Leader>rI<Tab><esc>o<backspace><Esc>

	set spl=fr
endfunction
au BufEnter,BufNew *.french :call LearnFrenchMode()
