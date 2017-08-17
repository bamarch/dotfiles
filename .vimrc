" First time?
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall

" FILEEXPLORE:
" :NT 			alias for NERDTree plugin
" :e			explore! old fashioned way
" :find			find path/to/file.py
" :Vex			split window vertical + explore mode

" PANESPLITTING:
" Ctrl+w,Ctrl+v split pane vertically
" Ctrl+w,Ctrl+s split pane horizontally
" Ctrl+w,arrow	focus new pane

" PANERESIZE:
" Ctrl+w,+      increase by one row (split)
" Ctrl+w,-		decrease by one row (split)
" Ctrl+w,>		increase by one col (vplit)
" Ctrl+w,<		decrease by one col (vsplit)
" Use prefixes [e.g.  Ctrl+w,10,+ increases the window size by 10 lines]
" Ctrl+w,= 		resize all windows to equal dimensions
" Ctrl+w,_		increase to max height
" Ctrl+w,|		increase to max width

" CHANGEINWORD:
" ciw			replace text within word boundary
" ci"			within ""
" ci(			within ()
" ci{			within {}

" TAG JUMPING:
" :MakeTags		create tags file (defined later)
" Ctrl+]	 	to jump to tag under cursor
" g,Ctrl+] 		for ambiguous tags
" Ctrl+t to 	jump back up the tag stack

" SESSIONS:
" :Obsess		store session
" vim -s		restore session

" AUTOCOMPLETE:
" Ctrl+x,Ctrl+[ autocomplete using tags
" Ctrl+n		search next infile
" Ctrl+p		search prev infile

" FUZZYFIND:
" :find *foo.py
" tab to expand
" :b lets you autocomplete any open buffer

" Enter the new millenium
" This must be first, because it changes other options as a side effect.
set nocompatible

" VUNDLE:
"     Setup
"        -git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"        -Launch vim and run :PluginInstall
"        -To install from command line: vim +PluginInstall +qall

"Turn off the default "filetype" controls temporarily because the way that vim caches filetype rules at runtime interferes with the way that vundle alters the runtime environment.
filetype off


" adjust vim's runtime path to include the vundle location and call the vundle initialization function
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" For GitHub repos, you specify plugins using the
" 'user/repository' format

" Could also repositories with a ".git" extension, like nerdtree
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

" Language specifc styling
" https://github.com/editorconfig/editorconfig-vim#readme
Plugin 'editorconfig/editorconfig-vim'

" Install tmux navigator
Bundle 'christoomey/vim-tmux-navigator'

" Obesssion
Bundle 'tpope/vim-obsession'

" All vundle Plugins must be added before the following line
call vundle#end()            " required
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on    " required

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" VIMRC
" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
if !exists("g:syntax_on")
    syntax enable
endif

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" Enable for-instance ä (a, ctrl+h, :)
set  digraph

" Enable recognition of arrow key codes starting with ESC
set esckeys

" Show ruler for the cursor i.e. line + col
set ruler

" Show the input of an incomplete command / autocomplete
set showcmd

" Visual bell, not beeping
set visualbell

" Insert indentation from current line when starting new one
set autoindent

" Use intelligent indentation for C++
set smartindent

" Smart tab yo
set smarttab

" No bells
set noerrorbells

" Dont expand tabs to spaces
" set noexpandtab

" Keep col position of cursor when moving through lines
set nostartofline

" Backspace with this value allows to use the backspace character (aka CTRL-H or "<-") to use for moving the cursor over automatically inserted indentation and over the start/end of line.
set backspace=2

" This allows to add text to a comment and still be within the comment after you start a new line. It also allows to break the line within a comment without breaking the comment.
set formatoptions=cqrt

" This makes Vim show a status line even when only one window is shown.
set laststatus=2

" This shortens about every message to a minimum and thus avoids scrolling within the output of messages and the "press a key" prompt that goes with these.
set shortmess=at

" This explicitly sets the width of text to 72 characters.
"set textwidth=72

" Which commands will "wrap" the cursor around the line borders. Cursor left/right keys as well as the 'h' and 'l' command.
set whichwrap=<,>,h,l

" Teach vim about comments
set comments=b:#,:%,n:>

" Highlight tabs and whitespace
" set list listchars=tab:»·,trail:·

" Store infomation between sessions
set viminfo=%,'50,\"100,:100,n~/.viminfo

" remap increment and decrement to use alt (avoid tmux clash)
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>

" Set paste mode when pasting into insert
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" End auto paste setting code


" Highlight matching braces
set showmatch

" Highlighting on/clear
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Set scrolling to not quite top of screen
set scrolloff=3

" Allow a load of tabpages
set tabpagemax=100

" Re-indent file
map <F7> mzgg=G`z

" c++ highlighting for .form files
au BufRead,BufNewFile *.form setfiletype cpp


" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" - :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" NERDTREE:
command NT NERDTree

" C++ IDE
command! Run !g++ %; ./a.out

" Give me closing braces!
"
" Whenever you type { then enter, auto format a block
 inoremap {<CR> {<CR><BS>}<Esc>ko

" Make it so that a curly brace automatically inserts an indented line
" inoremap {<CR> {<CR>}<Esc>O<BS><Tab>

" Ctrl + return, use after brace
" inoremap <C-Return> <CR><CR><C-o>k<Tab>

" Ctrl + Return between braces for win times
"imap <C-Return> <CR><CR><C-o>k<S-s>

" Gimme that other bracket whenever I bracket
" inoremap ( ()<ESC>ha

" Node run!
command! Node !node %

"No More Arrow Keys!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Identify too-long columns
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

