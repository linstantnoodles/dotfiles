set hidden
set laststatus=2

" visual autocomplete
set wildmode=list:longest,full
set wildmenu

set number
set relativenumber

set incsearch
set ignorecase
set smartcase

set ttymouse=xterm2
" kill extra margin below powerline
" set regex engine that doesnt break typescript 
set re=0

" keep the margins at bottom small
set cmdheight=1

" spaces > tabs :)

" number of spaces per tab character. affects text display
set tabstop=8
" convert tabs to spaces so that hitting tab / affects inserts
set expandtab
" number of whitespace chars to insert on tab and backspace
set softtabstop=4
" autoindentation settings
" number of whitespace chars to use when auto identing or re-indenting (<</>>)
" ops
set shiftwidth=4 
filetype indent on
" lang specific whitespace settings
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType vimwiki,markdown,ruby let b:coc_suggest_disable = 1

" theming
syntax on
colorscheme everforest
" basic theme for wiki files
autocmd BufEnter *.wiki colorscheme default

" tab creation and navigation
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>i
nnoremap J :tabprev<CR>
nnoremap K :tabnext<CR>

" directory change
nnoremap <leader>cd :cd %:p:h<CR>
" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction
" follow symlink and set working directory
autocmd BufRead *
  \ call SetProjectRoot()
" netrw: follow symlink and set working directory
autocmd CursorMoved silent *
  " short circuit for non-netrw files
  \ if &filetype == 'netrw' |
  \   call SetProjectRoot() |
  \ endif

" custom mappings
imap jj <Esc>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ls :ls<cr>:b<space>
" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nore ; :
nore , ;

" folding!
set foldenable        
set foldmethod=indent
" make sure all folds are open on start
set foldlevelstart=99 
" space open/closes folds
nnoremap <space> za

" prebuilt macros
let @a="i```pythonjj}i```"

" extended support for match motion %
runtime macros/matchit.vim

" netrw
let g:netrw_banner=0
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"
let g:netrw_liststyle=3
" per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

" toggle netrw
nnoremap <silent> ,e :Lexplore<cr>

" function for toggling line numbers for copying
function! NumberToggle()
  if(&rnu == 1)
    set nornu
    set nonumber
  else
    set rnu
    set number
  endif
endfunc
nnoremap <leader>l :call NumberToggle()<cr>

" indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" leafgarland/typescript-vim
let g:typescript_indent_disable = 1

" easymotion/vim-easymotion

" disable default mappings
let g:EasyMotion_do_mapping = 0
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

map <Leader>w <Plug>(easymotion-w)
map <Leader>b <Plug>(easymotion-b)
map <Leader>s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" vim-airline/vim-airline
let g:airline_theme='powerlineish'


" junegunn/fzf.vim 
let $FZF_DEFAULT_COMMAND='fd --type f -H -E .git'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --glob "!**/.git/**" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>r :Rg<CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>t :BTags<CR>
nnoremap <C-p> :Files<cr>

let g:fzf_history_dir = '~/.local/share/fzf-history'
" keep splits consistent with vim window split chars
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }
" default to hidden and allow toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']


" brecklen/vim-resize
" override with custom mappings
let g:vim_resize_disable_auto_mappings = 1

nnoremap <F2> :CmdResizeLeft<cr>
nnoremap <F3> :CmdResizeDown<cr>
nnoremap <F4> :CmdResizeUp<cr>
nnoremap <F5> :CmdResizeRight<cr>

" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-a> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

"TODO: https://andrew.stwrt.ca/posts/project-specific-vimrc/
"to override executable command
" use timpopes dispatch
let test#strategy = "dispatch"
let test#ruby#rspec#executable='docker compose exec web bundle exec rspec'

" emmet
let g:user_emmet_settings = {
\ 'javascript.jsx' : {
    \ 'extends': 'jsx',
    \ },
\}

" coc
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
let g:coc_disable_transparent_cursor = 1

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'breuckelen/vim-resize'
Plug 'dewyze/vim-ruby-block-helpers'
Plug 'easymotion/vim-easymotion'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-commentary'                             
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'honza/vim-snippets'
Plug 'vim-test/vim-test'
Plug 'hashivim/vim-terraform'
Plug 'Quramy/tsuquyomi'
Plug 'mattn/emmet-vim'
call plug#end()

