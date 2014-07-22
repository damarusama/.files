au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html
" change color on typos
au ColorScheme * :hi clear SpellBad
au ColorScheme * :hi SpellBad ctermbg=black

" indent help plugin
let g:indent_guides_auto_colors = 0
let g:vimwiki_folding = 1
let mapleader="'"
"set startfoldlevel=1
au BufWinLeave *.wiki mkview
au BufWinEnter *.wiki silent loadview
set fillchars+=fold:. 
let g:vimwiki_folding='syntax'
let g:vimwiki_use_mouse=1
au ColorScheme * :hi Folded ctermfg=22

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333 ctermbg=black 
:hi FoldColumn ctermbg=black ctermfg=black
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#222 ctermgb=grey
au FileType *  IndentGuidesEnable
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

"""""""""""""""""""""""""""""""""""""""""""""""""""""Plugins
set nocompatible               " be iMproved
filetype off                   " required!
"Vim bundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set ignorecase
au FileType md IndentGuidesDisable
set thesaurus+=/home/damaru/.vim/mthesaur.txt

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Bundles here:
" 
" original repos on github
"Bundle 'thanthese/Tortoise-Typing'
"Bundle 'mivok/vimtodo'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'einars/js-beautify'
Plugin 'maksimr/vim-jsbeautify'
"Plugin 'Townk/vim-autoclose'
Plugin 'pekepeke/vim-markdown-helpfile'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'dagwieers/asciidoc-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'mattn/flappyvird-vim'
Plugin 'mattn/calendar-vim'  
Plugin 'chrisbra/csv.vim'  
Plugin 'sophacles/vim-processing'
Plugin 'scrooloose/nerdtree'  
Plugin 'PotHix/Vimpress'
Plugin 'godlygeek/tabular'
"Plugin 'rosenfeld/conque-term'
Plugin 'Lokaltog/vim-powerline'
Plugin 'wookiehangover/jshint.vim'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'msanders/snipmate.vim'
Plugin 'mattn/emmet-vim'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'lsdr/monokai'
Plugin 'mustache/vim-mode'
"Plugin 'vim-scripts/VimRepress'
Plugin 'vimwiki/vimwiki'
Plugin 'plasticboy/vim-markdown'
" Plugin 'fholgado/minibufexpl.vim'
Plugin  'scrooloose/syntastic'
"Plugin 'nelstrom/vim-markdown-folding'
"Plugin 'mikewest/vimroom'

" vim-scripts repos
Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'

call vundle#end() 
filetype plugin indent on     " required!


""""""""""""""""""""""""""""""""""""""""""""""""""""General settings
set spell
set background=dark
"color jellybeans
colorscheme solarized
syntax on
set mouse:n
set ttymouse=xterm2
set number
set cursorline
set cuc
set autoindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""edit epub

au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

au BufReadCmd   *.epub      call zip#Browse

"Layout of the screen
"
let g:netrw_ignorenetrc=1

set et sw=2 sts=2
"let g:indent_guides_auto_colors = 1

" VimWiki styling
au FileType vimwiki setl nonumber


"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Custom key mapping

"mapping cw to s-bs
"map <C-[> <C-W>

" copy path of the open file in the register 
nnoremap <F2> :let @" = expand("%:p") <CR>
"add time to buffer
nnoremap <F3> "=strftime("%c")<CR>P
" Switch color, but also the tab color
nnoremap <F4> :call ColorSwitch()<CR>
" Toggle bg from solarized
call togglebg#map("<F5>")
" Enter writer room mode
nnoremap <F6> :call WriterMood()<CR>
nnoremap <F7> :call Taskindle()<CR>
map <Leader>s <Plug>VimwikiVSplitLink
set splitright
imap <tab> <c-x><c-o>
" remove the possibility to move in insert mode
" force to sheet back vim
ino <Up> <nop>
ino <BS> <C-w>
ino <Down> <nop>
ino <Left> <nop>
ino <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
:nmap D :! ./deploy


"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Functions

if &term =~ "xterm\\|rxvt"
	" use an orange cursor in insert mode
	let &t_SI = "\<Esc>]12;orange\x7"
	"     " use a red cursor otherwise
	let &t_EI = "\<Esc>]12;red\x7"
	silent !echo -ne "\033]12;red\007"
	" reset cursor when vim exits
	autocmd VimLeave * silent !echo -ne "\033]112\007"
	"               " use \003]12;gray\007 for gnome-terminal
endif

"setlocal foldmethod=syntax
"let html_folding=1

function Taskindle()
  exe ":Vimwiki2HTML"
  exe ":! sendKindle /home/damaru/vimwiki_html/index.html"
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""" writer room in vim
function WordCount()
let s:old_status = v:statusmsg
let position = getpos(".")
exe ":silent normal g\<c-g>"
let stat = v:statusmsg
let s:word_count =0 
if stat != '--No Lines in buffer--'
let s:word_count = str2nr(split(v:statusmsg)[11])
let v:statusmsg = s:old_status
end
call setpos('.',position)
return s:word_count
endfunction

func! WriterMood() 
setlocal formatoptions=tcq 
set scrolloff=999
set colorcolumn=80
set foldcolumn=9
set nonumber
set wrapmargin=80

set statusline=%{WordCount()}
"	set formatprg=par
	"setlocal wrap 
	"setlocal linebreak 
endfu

" the color switch function to change the scheme but also IndentGuide
let g:dark=1
fu! ColorSwitch()
	if g:dark
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333 ctermbg=lightgrey 
		let g:dark=0
ToggleBG
	else
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333 ctermbg=black 
		let g:dark=1
ToggleBG
	endif
endfu
