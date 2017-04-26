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
syntax on

" Show line numbers
set number

" Allow hidden buffers, don't limit to 1 file per window/split
set hidden

" http://www.guckes.net/vim/setup.html
set ai digraph ek    ru sc vb wmnu   noeb noet nosol
set bs=2 fo=cqrt ls=2 shm=at tw=72 ww=<,>,h,l 
set comments=b:#,:%,n:>
" Highlight tabs and whitespace
" set list listchars=tab:»·,trail:·
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
