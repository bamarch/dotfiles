" Enter the new millenium
" This must be first, because it changes other options as a side effect.
set nocompatible

" VUNDLE

"We also want to turn off the default "filetype" controls for now because the way that vim caches filetype rules at runtime interferes with the way that vundle alters the runtime environment.
filetype off
" Next, we'll need to then adjust vim's runtime path to include the vundle location we cloned from GitHub. After that, we will call the vundle initialization function
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'


" Install tmux navigator
Bundle 'christoomey/vim-tmux-navigator'

" Obesssion
Bundle 'tpope/vim-obsession'


" Now we can turn our filetype functionality back on
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
"set expandtab

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

" No bells
set noerrorbells

" Dont expand tabs to spaces
set noexpandtab

" Keep col position of cursor when moving through lines
set nostartofline

" Insert indentation from current line when starting new one
set autoindent

" Use intelligent indentation for C++
set smartindent

" Backspace with this value allows to use the backspace character (aka CTRL-H or "<-") to use for moving the cursor over automatically inserted indentation and over the start/end of line.
set backspace=2

" This allows to add text to a comment and still be within the comment after you start a new line. It also allows to break the line within a comment without breaking the comment.
set formatoptions=cqrt

" This makes Vim show a status line even when only one window is shown.
set laststatus=2

" This shortens about every message to a minimum and thus avoids scrolling within the output of messages and the "press a key" prompt that goes with these.
set shortmess=at

" This explicitly sets the width of text to 72 characters.
set textwidth=72

" Which commands will "wrap" the cursor around the line borders. Cursor left/right keys as well as the 'h' and 'l' command.
set whichwrap=<,>,h,l

" Teach vim about comments
set comments=b:#,:%,n:>

" Highlight tabs and whitespace
" set list listchars=tab:»·,trail:·

" Store infomation between sessions
set viminfo=%,'50,\"100,:100,n~/.viminfo


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
