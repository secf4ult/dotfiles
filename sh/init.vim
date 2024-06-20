" vim-plug
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'justinmk/vim-sneak'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/wandbox-vim'
Plug 'ellisonleao/gruvbox.nvim'

call plug#end()

" my config
set encoding=UTF-8
set nocompatible              " be improved, required
filetype off                  " required

" turn on filetype detection, load "ftplugin.vim" and "indent.vim"
syntax on

" set line number
set nu
" set tab
" how existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" on pressing tab, insert 4 spaces
set expandtab
" highlighting search matches
set hlsearch

" open NERDTree automatically when vim starts up on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" use <C-n> to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" close vim if NERDTree is only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" show match
" set showmatch
highlight Search ctermbg=white ctermfg=black
set cursorline

" matchpairs
:set mps+=<:>,`:`
:au FileType c,cpp,java set mps+==:;

" Plugin Settings
" set statusline plugin
set laststatus=2
set noshowmode

" Theme
set background=dark " or light
colorscheme gruvbox
