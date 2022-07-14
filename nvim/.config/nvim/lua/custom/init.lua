local opt = vim.opt



-- Indenting
opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true


vim.g.latex_to_unicode_tab=0

-- runs a script that cleans out tex build files whenever I close out of a .tex file.
vim.cmd("autocmd VimLeave *.tex !texclear %")

-- Ensure files are read as what I want:
vim.cmd("autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown")
vim.cmd("autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff")

-- NvChad uses neovim's filedetector by default (but I force it just in case and posterity)
-- this breaks julia-vim's Unicode support
-- so - revert it back when editing julia file
-- however, I cannot just load julia-vim lazily because devs are even more lazy
vim.g.did_load_filetypes=0
vim.g.do_filetype_lua=1
vim.cmd("autocmd BufRead,BufNewFile *.jl set filetype=julia")
vim.cmd("autocmd BufRead,BufNewFile *.jl let g:did_load_filetypes=1")
vim.cmd("autocmd BufRead,BufNewFile *.jl let g:do_filetype_lua=0")

-- save file as sudo on files that require root permission
vim.cmd("cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!")

-- automatically delete all trailing whitespace and newlines at end of file on save
vim.cmd([[
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
]])


-- turn off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable
vim.cmd([[
if &diff
    highlight! link DiffText MatchParen
endif
]])

--disable autocommenting on newline
vim.cmd("autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o")

-- autocompile dwmblocks
-- vim.cmd("autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & "})

-- needed to load python3, which is needed for latex-live-preview
-- why the hell is this required now???
vim.g.loaded_python3_provider=1
vim.g.python3_host_prog="/usr/bin/python3.10"
