set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
filetype indent on
set laststatus=2
set wildmode=list:longest,full
set wildmenu
set number
set relativenumber
set incsearch
set ttymouse=xterm2

runtime macros/matchit.vim

autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

let @a="i```pythonjj}i```"

" https://github.com/yous/dotfiles/blob/9070cd34b30f4fba6fa7a9de295c8560703ccc1e/vimrc
let s:rg_common = 'rg --column --line-number --no-heading --color=always ' .
  \ '--smart-case '
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   s:rg_common . '--fixed-strings ' . shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview(
  \     { 'options': '--delimiter : --nth 4..' }, 'right:50%'),
  \   <bang>0)
command! -bang -nargs=* -complete=dir Rgd
  \ call fzf#vim#grep(
  \   s:rg_common . '--fixed-strings ' . shellescape(''),
  \   1,
  \   fzf#vim#with_preview(
  \     { 'dir': fnamemodify(expand(<q-args>), ':p:h'),
  \       'options': '--delimiter : --nth 4..' },
  \     'right:50%'),
  \   <bang>0)
command! -bang -nargs=* Rgr
  \ call fzf#vim#grep(
  \   s:rg_common . shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({ 'options': '--delimiter : --nth 4..' },
  \     'right:50%'),
  \   <bang>0)

function! NumberToggle()
  if(&rnu == 1)
    set nornu
    set nonumber
  else
    set rnu
    set number
  endif
endfunc

" Netrw settings
let g:netrw_banner=0
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"
let g:netrw_liststyle=3

" Airline settings
let g:airline_theme='minimalist'

" Taglist Settings
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Close_On_Select = 1
let g:Tlist_Compact_Format = 1

imap jj <Esc>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>ls :ls<cr>:b<space>
nnoremap <leader>n :Lexplore<CR>
nnoremap <C-p> :Files<cr>
" Directory change
nnoremap <leader>cd :cd %:p:h<CR>

" Toggle netrw
nnoremap <silent> ,e :Lexplore<cr>

" Tab navigation
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
nnoremap J :tabprev<CR>
nnoremap K :tabnext<CR>

nnoremap <leader>r :Rg<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>l :call NumberToggle()<cr>


hi Search ctermbg=DarkGrey
colo fogbell
syntax on

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'breuckelen/vim-resize'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'                             
Plug 'jlanzarotta/bufexplorer'
Plug 'vimwiki/vimwiki'
call plug#end()

