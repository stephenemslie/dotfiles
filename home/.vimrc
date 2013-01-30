call pathogen#runtime_append_all_bundles()
call pathogen#infect()

ca w!! w !sudo tee "%"
" change to the directory of the current file: http://vim.wikia.com/wiki/Change_to_the_directory_of_the_current_file
set autochdir
" set t_Co=256
let g:ctrlp_working_path_mode = 'ra'
syntax enable
set background=dark
colorscheme solarized
set tabstop=4       " tabs should be 4 spaces
set expandtab
set shiftwidth=4    " shiftwidth should be 4
set autoindent      " auto indent
set ic              " ignore case
set smarttab
set is              " incremental search
set nowrap
filetype plugin on 
filetype indent on
set nocindent
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'fancy'

" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="normal"
" let g:solarized_visibility="normal"
" let g:solarized_diffmode="high"

" map nt :NERDTree<CR>

" for multiple windows
" set winwidth=110
" set winheight=30
map <C-h> <C-W><LEFT>
map <C-l> <C-W><RIGHT>
map <C-j> <C-W><DOWN>
map <C-k> <C-W><UP>

"highlight as SpecialKey, all characters after column 80
au BufNewFile,BufRead *.py exec 'match SpecialKey /\%>80c/'

"-- Use TAB to complete when typing words, else inserts TABs as usual.
"-- Uses dictionary and source files to find matching words to complete.

"-- See help completion for source,
"-- Note: usual completion is on <C-n> but more trouble to press all the time.
"-- Never type the same word twice and maybe learn a new spellings!
"-- Use the Linux dictionary when spelling is in doubt.
"-- Window users can copy the file to their machine.
"-- http://www.cs.albany.edu/~mosh - Mohsin Ahmed

function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction

:inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

:set  dictionary="/usr/dict/words"     

:command PDB :normal Oimport ipdb;ipdb.set_trace()

" function CSV()
"     " Convert csv text to columns (press u to undo).
"     " Warning: This deletes ',' and crops wide columns.
"     :let width = 20
"     :let fill = repeat(' ', width)
"     :%s/\([^,]*\),\=/\=strpart(submatch(1).fill, 0, width)/ge
"     :%s/\s\+$//ge
" endfunction

"
" Changes to allow blank lines in blocks, and
" Top level blocks (zero indent) separated by two or more blank lines.
"
" http://www.cs.albany.edu/~mosh - Mohsin,
" From Vim tip from Gerald Lai.
" Usage: source <thisfile> in pythonmode and
"  Press: vai, vii to select outer/inner python blocks by indetation.
"  Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
"

onoremap <silent>ai :<C-u>call IndTxtObj(0)<CR>
onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
vnoremap <silent>ai <Esc>:call IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii <Esc>:call IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
  let curcol = col(".")
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line("."))
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let pp = line(".") - 2
    let nextblank = getline(p) =~ "^\\s*$"
    let nextnextblank = getline(pp) =~ "^\\s*$"
    while p > 0 && ((i == 0 && (!nextblank || (pp > 0 && !nextnextblank))) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let pp = line(".") - 2
      let nextblank = getline(p) =~ "^\\s*$"
      let nextnextblank = getline(pp) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, curcol)
    let p = line(".") + 1
    let pp = line(".") + 2
    let nextblank = getline(p) =~ "^\\s*$"
    let nextnextblank = getline(pp) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && (!nextblank || pp < lastline && !nextnextblank)) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let pp = line(".") + 2
      let nextblank = getline(p) =~ "^\\s*$"
      let nextnextblank = getline(pp) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction 


