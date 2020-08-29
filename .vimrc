" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ThePrimeagen/vim-be-good'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" devicons always has to be last
Plug 'ryanoasis/vim-devicons'
call plug#end()

syntax on
autocmd vimenter * colorscheme gruvbox

map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['^node_modules$']
let g:airline_theme='wombat'
set number relativenumber
set expandtab
set shiftwidth=4
set background=dark
let mapleader = " "

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Enable autocompletion (in command mode as far as I know)
set wildmode=longest,list,full

" Split view on the bottom and on the right
set splitbelow splitright

" Disable auto commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions -=o

" Show whitespaces
set listchars=space:·,trail:-,tab:>-
set list

" Clipboard
vnoremap <C-c> "+y

" VSCode-like alt+movement line moving
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>

" Split windows moving mapping
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Toggle commenting
vmap <M-/> <plug>NERDCommenterToggle
nmap <M-/> <plug>NERDCommenterToggle

" Fuzzy search
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>p :History<CR>

" ------------ COC ---------------
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Prettier mapping
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <C-i> :Prettier<CR>
