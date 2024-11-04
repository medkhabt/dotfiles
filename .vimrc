syntax on
"packadd! doki-theme
set termguicolors
set cursorline
"colo nakano_nino 
"colo zaibatsu
colorscheme evening  
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
highlight CursorLine cterm=none ctermbg=lightgray ctermfg=black guibg=#FFD700 guifg=black
load-plugins

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:pdf_auto_refresh = 0 

function! TogglePdfAutoRefresh()
    let l:pdf_file = expand('%:r') . '.pdf'

    if g:pdf_auto_refresh == 0
        let g:pdf_auto_refresh = 1
         " Construct the command and echo it for debugging
          silent! call system('evince ' . shellescape(l:pdf_file) . ' >/dev/null 2>&1 &')   
        " Run evince with the PDF file
         echo "PDF Auto-Refresh: ON"
    else
        let g:pdf_auto_refresh = 0 
        echo "PDF Auto-Refresh: OFF"
    endif
endfunction



call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


nnoremap ,goe "cyiw :read $HOME/.vim/.skeleton_go_err.txt <CR> 0f "cp=2jji 
nnoremap ,/ _i//<Esc> 
nnoremap ,b :BTags<CR>

augroup filetype_cpp
    autocmd!
    autocmd BufWritePost *.cpp normal gg=G''zz
    "TODO custumize the ctag depending on the extension of the file, for now it is
    "cpp.
    autocmd BufWritePost *.cpp,*.h silent execute '!ctags -R --sort=no --c++-kinds=+p-n --fields=+iaS --extras=+q --language-force=C++ . '
augroup END

augroup syncNotes
    autocmd!
    autocmd BufWritePost */Dev/* silent execute !pushSync
    autocmd BufReadPre */Dev/* silent execute !pullSync
augroup END

augroup pdfTex
    autocmd!
    autocmd FileType tex nnoremap <buffer> <C-G> :call TogglePdfAutoRefresh()<CR>
    autocmd BufWritePost *.tex if g:pdf_auto_refresh | 
                \ execute 'silent! !openPdfFromTex ' . shellescape(expand('%:r')) . ' >/dev/null 2>&1' | 
                \ endif
augroup END


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


