set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

set wildmenu
set wildmode=longest:list,full

call plug#begin('~/.config/nvim/plugged')
Plug 'JuliaEditorSupport/julia-vim'
Plug 'jpalardy/vim-slime'
Plug 'scrooloose/nerdtree'
Plug 'neovim/nvim-lspconfig'
Plug 'ervandew/supertab'
call plug#end()

nnoremap <F4> :NERDTreeToggle<CR>


"JULIA STUFF
let g:slime_paste_file = "$HOME/.cache/slime_paste"

autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
lua << EOF
require'lspconfig'.julials.setup{
    on_new_config = function(new_config,new_root_dir)
      server_path = "/home/ivan/.julia/packages/LanguageServer/y1ebo/src"
      cmd = {
        "julia",
        "--project="..server_path,
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
          using Pkg;
          Pkg.instantiate()
          using LanguageServer; using SymbolServer;
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
          project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
          # Make sure that we only load packages from this environment specifically.
          @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
          server.runlinter = true;
          run(server);
        ]]
    };
    new_config.cmd = cmd
    end
}
EOF

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
