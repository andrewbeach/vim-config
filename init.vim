set nocompatible            " disable compatibility to old-time vi
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> 
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set cursorline              " highlight current line 
set cursorcolumn            " highlight current column
set autoindent              " indent a new line the same as the line just typed
set splitbelow
set splitright
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cmdheight=2 

let mapleader = ","

filetype on
filetype plugin indent on   " allows auto-indenting dependig on file type
syntax on                  " syntax highlighting

call plug#begin('~/.config/nvim/plugged')

" Git 
Plug 'https://github.com/tpope/vim-fugitive'

" Search 
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
map <silent> <Leader>p :CtrlP()<CR>
nmap ff :FZF<CR>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" Sneak 
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'

" Syntax
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/dense-analysis/ale.git'
let b:ale_fixers = {'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']}
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

" Snippets 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Haskell
Plug 'https://github.com/neovimhaskell/haskell-vim.git'
Plug 'Twinside/vim-hoogle'
let g:hoogle_search_bin = 'stack hoogle --'
nmap <Leader>hh :Hoogle 
nmap <Leader>HH :Hoogle <CR>
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

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 
  \ 'coc-tsserver'
  \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>D :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
xmap <leader>c  <Plug>(coc-codeaction-selected)
nmap <leader>c  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>cc  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cf  <Plug>(coc-fix-current)

" Org 
Plug 'jceb/vim-orgmode'

" Purescript 
Plug 'https://github.com/raichoo/purescript-vim.git'
Plug 'frigoeu/psc-ide-vim'

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Language Client
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next', 
    \ 'do': 'bash install.sh', 
    \ }

" Fsharp 
Plug 'ionide/Ionide-vim', {
    \ 'do': 'make fsautocomplete', 
    \ }

" Idris 
Plug 'https://github.com/idris-hackers/idris-vim.git'

" Html
Plug 'othree/html5.vim'

" Nerdtree
Plug 'https://github.com/preservim/nerdtree.git'
map <Leader>n :NERDTreeToggle %<CR>
call plug#end()
silent! helptags ALL
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
map <Leader>ep :echo @%<cr>

" Macros
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Brackets
set showmatch " show matching brackets.

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
