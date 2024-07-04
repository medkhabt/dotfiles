syntax on
"packadd! doki-theme
set termguicolors
set cursorline
"colo nakano_nino 
"colo zaibatsu
set wildmenu
set wildmode=list:longest
set showcmd
set showmode
set cursorline
set relativenumber
set number
set ruler
set visualbell
set title
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set nowrap
set incsearch
set ignorecase
set smartcase
set hlsearch
set clipboard^=unnamed

load-plugins

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


nnoremap ,goe "cyiw :read $HOME/.vim/.skeleton_go_err.txt <CR> 0f "cp=2jji 
nnoremap ,/ _i//<Esc> 
nnoremap ,b :BTags<CR>

command! MakeTags !ctags -R .
nnoremap ,f :Files .<CR>
nnoremap <c-f><c-n> :Rg <c-r><c-w><CR> 
nnoremap ,rg :RG <CR>


" For setting the working directory to the path i specified with vim command,
" so i won't have troubles when using fzf ( context of the search is within
" the project directory)
augroup cdpwd
    autocmd!
    autocmd VimEnter * lcd %:p:h 
augroup END

