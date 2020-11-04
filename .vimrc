set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on
set laststatus=2
set wildmode=list:longest,full
set wildmenu
set number
set mouse=a
set ttymouse=xterm2
let g:netrw_banner=0
let g:netrw_liststyle=3

imap jj <Esc>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ls :ls<cr>:b<space>
nnoremap <leader>n :Lexplore<CR>
nnoremap <C-p> :Files<cr>
" Tab navigation
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
nnoremap J :tabprev<CR>
nnoremap K :tabnext<CR>
nnoremap <silent> <C-K><C-T> :TagbarToggle<CR>

hi Search ctermbg=DarkGrey
colo delek 
syntax on

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'                             
Plug 'breuckelen/vim-resize'
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-system-copy'
call plug#end()

