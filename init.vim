set nocompatible            " disable compatibility to old-time vi
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results

set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> 
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same as the line just typed
set splitbelow
set splitright
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions

filetype on
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

call plug#begin('~/.config/nvim/plugged')

" Git 
Plug 'https://github.com/tpope/vim-fugitive'

" Search 
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
map <silent> <Leader>p :CtrlP()<CR>
let g:ctrlp_custom_ignore = '\v[\/]dist$'

" Syntax
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/dense-analysis/ale.git'
let b:ale_fixers = {'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']}

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

" Haskell
Plug 'https://github.com/neovimhaskell/haskell-vim.git'
let g:haskell_enable_quantification = 1
let g:haskell_enable_pattern_synonyms = 1
map <Leader>hs :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 
  \ 'coc-tsserver'
  \ ]

" Purescript 
Plug 'https://github.com/raichoo/purescript-vim.git'
Plug 'frigoeu/psc-ide-vim'

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>do <Plug>(coc-codeaction)

" PHP
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'

" Language Client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next', 
    \ 'do': './install.sh', 
    \ }
let g:LanguageClient_loggingFile = '/tmp/lc.log'
let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper', '--lsp'] }
map tt :call LanguageClient#textDocument_hover()<CR>
map td :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Fsharp 
Plug 'ionide/Ionide-vim', {
    \ 'do': 'make fsautocomplete', 
    \ }

" Javascript
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/othree/javascript-libraries-syntax.vim'

" Idris 
Plug 'https://github.com/idris-hackers/idris-vim.git'

" Html
Plug 'othree/html5.vim'

" AngularJS
Plug 'https://github.com/burnettk/vim-angular'

" Nerdtree
Plug 'https://github.com/preservim/nerdtree.git'
map <Leader>n :NERDTreeToggle<CR>

call plug#end()

silent! helptags ALL

let mapleader = ","

let g:used_javascript_libs = 'angularjs,react,ramda,jquery'

noremap ;; :%s///g<Left><Left><Left>

set completeopt=longest,menuone 
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Navigation
map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $
noremap <C-x> :bp<Bar>bd #<Cr>
noremap <C-h> gT
noremap <C-l> gt

" Macros
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Brackets
set showmatch " show matching brackets.

" php / html mode switching 
map <leader>mp :set ft=php<CR>
map <leader>mh :set ft=html<CR>

" Search
nnoremap <leader>aa  :Ack!<space>
nnoremap <leader>aww :Ack! <cword><cr>
nnoremap <leader>aw  :Ack! --ignore-dir "dist" <C-r>=expand('<cword>')<cr>
nnoremap <leader>aWW :Ack! --ignore-dir "dist" <cWORD><cr>
nnoremap <leader>aW  :Ack! --ignore-dir "dist" <C-r>=expand('<cWORD>')<cr>
nnoremap <silent> <leader><space> :nohl<cr>

" Syntax Checking 
nnoremap <leader>ale :ALEFix eslint<cr> 
nnoremap <leader>x :ALEFix eslint<cr>

nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>
nnoremap <leader>q :q<cr>

" Buffers and Files
nnoremap <leader>b :b<space>
nnoremap <leader>f :e<space>**/*/
set wildmenu 
set wildignore+=*.gif,*.ico,*.png
set wildignore+=*.pdf
set wildignore+=node_modules/*,bower_components/*

" Windows 
nnoremap <leader>wv <C-w>v<C-w>l
nnoremap <leader>wh <C-w>s<C-w>l
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>

" Tabs
nnoremap <leader>t :tab drop<space>

" File Shortcuts
nnoremap <leader><C-I> :tab drop ~/.config/nvim/init.vim <cr>

" Copy Paste
vnoremap <C-c> "*y

" Allow local project vim config
set exrc
set secure
