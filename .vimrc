" This is Ivan Balashov's .vimrc file
" vim:set ts=2 sts=2 sw=2 expandtab:

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'off':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'whatyouhide/vim-gotham'
Plug 'powerline/powerline'
"Plug 'Valloric/YouCompleteMe'
Plug 'bling/vim-airline'
"set guifont=Liberation\ Mono\ for\ Powerline\ 10 
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
"Plug 'ntpeters/vim-better-whitespace'
" Plug 'user/repo1', 'branch_or_tag'
" Plug 'user/repo2', { 'rtp': 'vim/plugin/dir', 'branch': 'devel' }
" Plug 'git@github.com:junegunn/vim-github-dashboard.git'
" Plug '/my/local/vim/plugin'
" ...
"
Plug 'Yggdroot/indentLine'

Plug 'Keithbsmiley/investigate.vim'
nnoremap <F1> :call investigate#Investigate()<CR>



call plug#end()


" vim-better-whitespace
"let g:better_whitespace_enabled = 0
"nmap ^[w :ToggleWhitespace<CR>
"nmap <Leader>dw :StripWhitespace<CR>


let g:indentLine_enabled    = 0
let g:indentLine_char       = '¦'
let g:indentLine_color_term = 239
let g:indentLine_color_gui  = '#A4E57E'
nmap ^[i :IndentLinesToggle<CR>


" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>

colorscheme gotham
set laststatus=2


" dvorak remap
noremap h h
noremap t j
noremap n k
noremap s l
noremap j t
noremap k n
noremap l s
noremap J T
noremap K N
noremap L S
noremap T J
noremap N K
noremap S L

inoremap jj <esc>
inoremap kk <esc> 
inoremap кк <esc>


vmap <C-S-c> "+yi
vmap <C-S-x> "+c
vmap <C-S-v> c<ESC>"+p
imap <C-S-v> <C-S-r><C-o>+
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar


" номера строк
set nu
set nuw=4
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


"autocmd InsertEnter * call SetInsertLayout()
"autocmd InsertLeave * call SetNormalLayout()
"autocmd CmdwinEnter * call SetNormalLayout()


"function! SetNormalLayout()
    "if has('unix') && &term == 'builtin_gui'
        ""silent !dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.set_layout uint32:0 >/dev/null
        ""silent !qdbus ru.gentoo.KbddService /ru/gentoo/KbddService  ru.gentoo.kbdd.set_layout 0 >/dev/null
          
  "silent! !/usr/bin/dbus-send
    "\ --session
    "\ --dest=ru.gentoo.KbddService
    "\ /ru/gentoo/KbddService
    "\ ru.gentoo.kbdd.set_layout uint32:0
        "silent !notify-send "NORMAL" "layout" >/dev/null
    "endif
"endfunction

"function! SetInsertLayout()
    "if has('unix') && &term == 'builtin_gui'
        "silent !notify-send "INSERT" "layout" >/dev/null
      "endif
"endfunction


augroup kbdd
  autocmd!
  autocmd InsertLeave * call s:KbddSetEnLayout()
  autocmd InsertEnter * call s:KbddSetRememberedInsertModeLayout()
augroup END

let s:kbdd_insert_mode_layout = 0

function! s:KbddSetEnLayout()
  silent! let l:current_layout = systemlist('/usr/bin/dbus-send'
    \.' --session'
    \.' --print-reply=literal'
    \.' --dest=ru.gentoo.KbddService'
    \.' /ru/gentoo/KbddService'
    \.' ru.gentoo.kbdd.getCurrentLayout'
    \)
  if v:shell_error == 0
    " First output string is expected to be alike "uint32 0".
    let s:kbdd_insert_mode_layout = l:current_layout[0][-1:]
  endif
  silent! !/usr/bin/dbus-send
    \ --session
    \ --dest=ru.gentoo.KbddService
    \ /ru/gentoo/KbddService
    \ ru.gentoo.kbdd.set_layout uint32:0
  
  silent !notify-send "NORMAL" "layout" >/dev/null
endfunction

function! s:KbddSetRememberedInsertModeLayout()
  execute 'silent! !/usr/bin/dbus-send'
    \.' --session'
    \.' --dest=ru.gentoo.KbddService'
    \.' /ru/gentoo/KbddService'
    \.' ru.gentoo.kbdd.set_layout uint32:'.s:kbdd_insert_mode_layout
endfunction




if version >= 700
    set history=64
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

