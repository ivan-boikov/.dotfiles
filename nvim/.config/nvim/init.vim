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
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

let mapleader = " "

call minpac#add('k-takata/minpac', {'type': 'opt'})

" general improvements
call minpac#add('lukas-reineke/indent-blankline.nvim')
call minpac#add('tpope/vim-characterize') " improvements to <ga>
call minpac#add('tpope/vim-commentary') " comment out: <gc> selection, <gcc> line
call minpac#add('tpope/vim-eunuch') " UNIX stuff: :Wall, :Delete, :Remove
call minpac#add('tpope/vim-sleuth') " autodetect shiftwidth
call minpac#add('tpope/vim-surround') " <cs"'> inside "Hello" changes to 'Hello'
call minpac#add('nelstrom/vim-visual-star-search') " visual select + <*> = find selected
call minpac#add('godlygeek/tabular') "  :Tabularize /,/r0 = align by , and align right
call minpac#add('luukvbaal/nnn.nvim')
call minpac#add('folke/which-key.nvim')
call minpac#add('roblillack/vim-bufferlist')

" theming
call minpac#add('joshdick/onedark.vim')
call minpac#add('itchyny/lightline.vim')

" dev
call minpac#add('jpalardy/vim-slime')
call minpac#add('JuliaEditorSupport/julia-vim')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('nvim-treesitter/nvim-treesitter')
"call minpac#add('Issafalcon/lsp-overloads.nvim')
call minpac#add('kyazdani42/nvim-web-devicons')
call minpac#add('folke/trouble.nvim')
call minpac#add('hrsh7th/cmp-nvim-lsp')
call minpac#add('hrsh7th/cmp-nvim-lsp-document-symbol')
call minpac#add('hrsh7th/cmp-nvim-lsp-signature-help')
call minpac#add('amarakon/nvim-cmp-buffer-lines')


" snippets
call minpac#add('hrsh7th/nvim-cmp')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/cmp-path')
call minpac#add('hrsh7th/cmp-cmdline')
call minpac#add('hrsh7th/cmp-nvim-lua')
call minpac#add('L3MON4D3/LuaSnip')
call minpac#add('saadparwaiz1/cmp_luasnip')
call minpac#add('ivan-boikov/friendly-snippets')

call minpac#add('lervag/vimtex')
call minpac#add('vimwiki/vimwiki')

"call minpac#add('')

if empty(glob("~/.config/nvim/pack/minpac/start/friendly-snippets"))
    call minpac#update()
    echo "Wait for packages to install, then restart nvim one last time"
    finish
endif



map <silent> <C-b> :call BufferList()<CR>


set background=dark
set termguicolors
colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" Indenting
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set noexpandtab       " Expand TABs to spaces
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on
" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

let g:sleuth_tex_defaults = 'tabstop=4'

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



nmap <M-Tab> :bnext<CR>
nmap <M-w> :bd<CR>
nmap <S-Tab> :bprev<CR>




let g:latex_to_unicode_keymap = 1
"let g:latex_to_unicode_tab=1
let g:latex_to_unicode_file_types = ".jl"

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
let g:slime_cell_delimiter = "\n"


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


lua << EOF
    require'lspconfig'.julials.setup{}
EOF
nmap <leader>ld :lua vim.lsp.buf.declaration()<CR>
nmap <leader><leader> :lua vim.lsp.buf.hover()<CR>
nmap <leader>ll :lua vim.lsp.util.show_line_diagnostics()<CR>
nmap <leader>lk :lua vim.lsp.buf.signature_help()<CR>
nmap <leader>lr :lua vim.lsp.buf.references()<CR>

"let g:latex_to_unicode_auto = 1
" just in case to avoid interference with tab-completion
"let g:latex_to_unicode_tab = "off"

let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_method = 'latexmk'

"let g:vimtex_compiler_latexmk = {
"            \ 'hooks' : [],
"            \ 'executable' : 'latexmk',
"            \ 'callback' : 1,
"            \ 'continuous' : 1,
"            \ 'options' : [
"            \ '-shell-escape',
"            \ 'interaction=nonstopmode',
"            \ '-file-line-error'
"            \ ],
"            \ }

let g:vimtex_compiler_latexmk = {
            \ 'options' : [
            \ '-shell-escape',
            \ '-synctex=1',
            \ '-interaction=nonstopmode',
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

        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
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
        }),

        sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help' },
                { name = 'buffer-lines' },
                { name = 'nvim_lsp' },
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users
            },
            {{ name = 'buffer' }
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
        })

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

    require'cmp'.setup {
        sources = {
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "path" },
            },
    }
    require("luasnip.loaders.from_vscode").lazy_load()
EOF



" nnn browser integration
lua << EOF
    require("nnn").setup()
EOF
nmap <C-n> :NnnPicker cmd=nnn -deAU<CR>



let g:julia_blocks = 0
let g:julia_indent_align_import = 0
let g:julia_indent_align_brackets = 0
let g:julia_indent_align_funcargs = 0
let g:julia_set_indentation = 0
let g:latex_to_unicode_file_types = ".jl"

hi link juliaComma Comment
hi link juliaParDelim Comment
hi link juliaSemicolon Comment
hi link juliaFunctionCall Function
