set number
syntax on
set encoding=utf-8

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
map J 5j
map K 5k
map H b
map L w

" call plug#begin()
" Plug 'preservim/NERDTree'
" "Plug 'neoclide/coc.vim', {'branch': 'release'}
" Plug 'itchyny/lightline.vim'
" Plug 'https://github.com/itchyny/vim-gitbranch'
" call plug#end()
" "lightline
" set laststatus=2
" let g:lightline = {
"       \ 'colorscheme': 'deus',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'filename', 'readonly', 'modified', 'gitbranch' ] ],
"       \ 
"       \   'right': [ [ 'lineinfo' ],
"       \              [ 'percent' ],
"       \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'gitbranch#name',
"       \ },
"       \ }
" set noshowmode
" nmap <C-n> :NERDTree <C-R>
