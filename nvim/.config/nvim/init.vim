let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
"Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'christoomey/vim-tmux-navigator'
call plug#end()


" experimental
set title
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd


set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

" enforce tab width
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
" don't use acual <Tab> character
set expandtab 

" autocompletion
set wildmode=longest:list,full

" no automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" perform dot commands over visual blocks
vnoremap . :normal .<CR>

" spell-check set to <leader>o, 'o' for 'orthography'
map <leader>o :setlocal spell! spelllang=en_us<CR>

" splits open at the bottom and right, which is non-retarded, unlike vim defaults
set splitbelow splitright

" nerd tree
nnoremap <F4> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
    let NERDTreeBookmarksFile = stdpath('config') . '/nerdtree-bookmarks'
else
    let NERDTreeBookmarksFile = '~/.config/.vim/nerdtree-bookmarks'
endif

" shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" replace ex mode with gq
map Q gq

" check file in shellcheck
map <leader>s :!clear && shellcheck -x %<CR>

" open bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" automatically delete all trailing whitespace and newlines at end of file on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" turn off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable
if &diff
    highlight! link DiffText MatchParen
endif

" toggling the bottom statusbar
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

let g:deoplete#enable_at_startup = 1

let g:vimtex_view_method = 'zathura'

call deoplete#custom#var('omni', 'input_patterns', {
    \ 'tex': g:vimtex#re#deoplete
    \})

"JULIA STUFF

let g:slime_paste_file = "$HOME/.cache/slime_paste"
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
"lua << EOF
"require'lspconfig'.julials.setup{
"    on_new_config = function(new_config,new_root_dir)
"      server_path = "/home/ivan/.julia/packages/LanguageServer/y1ebo/src"
"      cmd = {
"        "julia",
"        "--project="..server_path,
"        "--startup-file=no",
"        "--history-file=no",
"        "-e", [[
"          using Pkg;
"          Pkg.instantiate()
"          using LanguageServer; using SymbolServer;
"          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
"          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
"          # Make sure that we only load packages from this environment specifically.
"          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
"          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
"          server.runlinter = true;
"          run(server);
"        ]]
"    };
"    new_config.cmd = cmd
"    end
"}
"EOF

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" TEX Live Preview
nnoremap <F7> :LLPStartPreview<CR>
let g:livepreview_previewer = 'zathura'
let g:livepreview_use_biber = 1
let g:livepreview_cursorhold_recompile = 1

set updatetime=1000
