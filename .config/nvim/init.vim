"" Auto install vim-plug
if empty(glob("$VIM/autoload/plug.vim"))
    silent !curl -sfLo $VIM/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

"" Plugins
call plug#begin()

" Editing
Plug 'matze/vim-move'
let g:move_map_keys = 0

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=['ultisnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'js': { 'left': '/* ','right': ' */' } }

Plug 'w0rp/ale'
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_enter = 1
let g:ale_lint_delay = 300
let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'typescript': ['prettier'],
\  'typescriptreact': ['prettier'],
\  'scss': ['prettier'],
\}
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['eslint', 'tsserver'],
\  'typescriptreact': ['eslint', 'tsserver'],
\  'scss': ['stylelint']
\}

Plug 'Valloric/YouCompleteMe'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

Plug 'mtth/scratch.vim'
let g:scratch_autohide=1
let g:scratch_insert_autohide=0

Plug 'editorconfig/editorconfig-vim'
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key = '<C-n>'
let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'

Plug 'cohama/lexima.vim'

" File navigation
Plug 'qpkorr/vim-bufkill'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize=60
let g:NERDTreeQuitOnOpen=1

Plug 'vim-scripts/Rename2'

" Language support
"" TeX
Plug 'lervag/vimtex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_open_on_warning=0

"" JavaScript
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

"" TypeScript
Plug 'HerringtonDarkholme/yats.vim'

"" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
let g:alchemist_mappings_disable = 1

" UI
Plug 'junegunn/vim-slash'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys=0

Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 1
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'ernstwi/vim-sticky'
let g:sticky_all = ['background']

Plug 'Yilin-Yang/vim-markbar'
Plug 'ryanoasis/vim-devicons'
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_nerdtree = 1
" Folder icon fix
highlight! link NERDTreeFlags NERDTreeDir

call plug#end()

"" Settings
" Airline
let g:lightline = {'colorscheme': 'one'}

let g:airline_section_a = airline#section#create(['mode'])
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1

" Colors
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark
colorscheme one

" Leader setting
let g:mapleader=','
" Color vertical line at 80 chars
set colorcolumn=80
" Enable using the mouse to select position
set mouse=a
" Show line numbers
set number
" Match brackets etc
set showmatch

" Break lines
set linebreak
set showbreak=+++

" Indentation
set cindent
set smarttab
set shiftwidth=8

" Spelling
set spelllang=en_gb

" Allow project specific .nvimrc
set exrc
set secure

filetype plugin on

"" Keyboard shortcuts
" Insert new lines
nmap <CR> o
nmap <leader><CR> $a,<CR>

" Reformat code
nmap <leader>f :Neoformat<CR>
nmap <leader>F gg=Gg;
vmap <leader>f :Neoformat<CR>
vmap <leader>F gg=Gg;
" Clean whitespace
nmap <leader>cw :%s/\s\+$//e<cr>``

" Move faster
nmap J 5j
nmap K 5k
vmap J 5j
vmap K 5k

nmap M <Plug>(easymotion-overwin-f)

" Move cursor to previous position
nmap B ``

" Line movement
nmap _ ^
nmap - $

" Save
nmap s :w<CR>
nmap S :SSave<CR>

" Redo
nmap U <C-R>

" Remove highlighting
nmap <leader>n :noh<CR>

"Move visually selected block
vmap <C-h> <Plug>MoveBlockLeft
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
vmap <C-l> <Plug>MoveBlockRight
vmap <space>h 5<Plug>MoveBlockLeft
vmap <space>j 5<Plug>MoveBlockDown
vmap <space>k 5<Plug>MoveBlockUp
vmap <space>l 5<Plug>MoveBlockRight

" Sort visually selected lines
vmap s :sort<CR>

" Copy visual selection to system clipboard
vmap sy "*y

" Reload init.vim
nmap <C-l> :source $MYVIMRC<CR>

" Rename file
nmap <C-r> :call feedkeys(":Rename " . expand('%@'))<CR>

" Plugin keys
nmap <space> :CtrlPBuffer<CR>
nmap t :TagbarToggle<CR>
nmap <leader><space> :NERDTreeToggle<CR>

" Splits
set splitbelow
set splitright
nmap <leader>sh :vs<CR>
nmap <leader>sv :split<CR>
nmap <UP> <C-W>k
nmap <DOWN> <C-W>j
nmap <LEFT> <C-W>h
nmap <RIGHT> <C-W>l

nmap <S-UP> :resize -5<CR>
nmap <S-DOWN> :resize +5<CR>
nmap <S-LEFT> :vertical resize -5<CR>
nmap <S-RIGHT> :vertical resize +5<CR>

" Map scratch
nmap <BS> :Scratch<CR>

" Unmap ex mode
:nnoremap Q <Nop>

" Close buffer
nmap QQ :BD<CR>
tmap QQ :bd!<CR>

" Toggle light/dark colorscheme
nmap § :call ToggleColorMode()<CR>
" Toggle Goyo
nmap §§ :call ToggleGoyo()<CR>

" YouCompleteMe
nmap gd :YcmCompleter GoToDefinition<CR>

" Remap ESC in input mode
imap jj <C-c>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Command line
cmap <A-BS> <C-W>

"" Auto commands
" Restore position in closed buffers
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$")    |
            \   exe "normal! g`\"" 			        |
            \ endif
set viminfo^=%

"" Functions
function! ToggleColorMode()
    if (&background == "light")
        set background=dark
    else
        set background=light
    endif
endfunction

let s:goyo_enabled = 0
function! ToggleGoyo()
    if s:goyo_enabled == 0
        let s:goyo_enabled = 1
        Goyo 81x100%
    else
        let s:goyo_enabled = 0
        Goyo!
    endif
endfunction

" Set filetype for tsx
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
augroup END
