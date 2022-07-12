-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

--print("custom/init.lua")
--print("custom/init.lua")

local opt = vim.opt

-- Indenting
opt.expandtab = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- runs a script that cleans out tex build files whenever I close out of a .tex file.
vim.cmd("autocmd VimLeave *.tex !texclear %")

-- Ensure files are read as what I want:
vim.cmd("autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown")
vim.cmd("autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff")
vim.cmd("autocmd BufRead,BufNewFile *.tex set filetype=texclear")

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

-- -- autocompile dwmblocks
-- vim.cmd("autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & "})

-- must be here and not in lazy loader parameters
vim.g.livepreview_previewer = "zathura"
