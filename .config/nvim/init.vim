" =========================
" vim-plug
" =========================

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" =========================
" Plugins
" =========================

call plug#begin()

" -------------------------
" Editing
" -------------------------

Plug 'Shougo/neosnippet.vim'
Plug 'cohama/lexima.vim'
Plug 'matze/vim-move', { 'on': ['<plug>MoveBlockDown', '<plug>MoveBlockUp'] }
Plug 'preservim/nerdcommenter'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-surround'

" -------------------------
" Languages
" -------------------------

Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim', { 'for': ['elixir'] }
Plug 'amiralies/vim-rescript'

" -------------------------
" LSP
" -------------------------

Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'

" -------------------------
" UI
" -------------------------

Plug 'itchyny/lightline.vim'
Plug 'mihaifm/bufstop'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'preservim/nerdtree', {
\	'on': ['NERDTree', 'NERDTreeClose', 'NERDTreeFind'],
\}
Plug 'rakr/vim-one'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" -------------------------
" Utilities
" -------------------------

Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'qpkorr/vim-bufkill'
Plug 'zivyangll/git-blame.vim', { 'on': ['GitBlame'] }

call plug#end()


" =========================
" vim settings
" =========================

filetype plugin on

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

" No need to show the mode, shown in the status line
set noshowmode

" Preview substitutes
set inccommand=nosplit

" Store viminfo
set viminfo^=%

" Break lines
set linebreak
set showbreak=>>>
set wrap

" Indentation
set cindent
set smarttab
set shiftwidth=8

" Allow project specific .nvimrc
set exrc
set secure

" Splits
set splitbelow
set splitright

" Completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c


" -------------------------
" Colorscheme
" -------------------------

if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has('termguicolors'))
	set termguicolors
endif

colorscheme one
set background=dark


" =========================
" Plugin settings
" =========================

let g:BufKillCreateMappings = 0
let g:move_map_keys = 0
let g:rustfmt_autosave = 1

let g:alchemist_mappings_disable = 1

" -------------------------
" Lightline
" -------------------------

let g:lightline = {
\	'colorscheme': 'one',
\	'active': {
\		'left': [
\			['mode', 'paste'],
\			['filename', 'readonly', 'modified'],
\		],
\	},
\	'separator': { 'left': '', 'right': '' },
\	'subseparator': { 'left': '', 'right': '' }
\}

" -------------------------
" ALE
" -------------------------

let g:ale_completion_enabled = 0
let g:ale_completion_tsserver_autoimport = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 300
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\	'javascript': ['prettier'],
\	'typescript': ['prettier'],
\	'typescriptreact': ['prettier'],
\	'scss': ['prettier'],
\	'swift': ['swiftformat']
\}
let g:ale_linters = {
\	'javascript': ['eslint'],
\	'typescript': ['eslint'],
\	'typescriptreact': ['eslint'],
\	'scss': ['stylelint', 'prettier']
\}

" -------------------------
" LSP + Diagnostics
" -------------------------

lua << EOF
	lsp = require 'lspconfig'

	local on_attach_vim = function()
		require'completion'.on_attach()
	end

	lsp.clangd.setup { on_attach=on_attach_vim }
	lsp.diagnosticls.setup { on_attach=on_attach_vim }
	lsp.elixirls.setup { on_attach=on_attach_vim }
	lsp.rust_analyzer.setup { on_attach=on_attach_vim }
	lsp.solargraph.setup { on_attach=on_attach_vim }
	lsp.tsserver.setup { on_attach=on_attach_vim }
	lsp.vimls.setup { on_attach=on_attach_vim }
EOF


let g:completion_enable_snippet = 'Neosnippet'
let g:diagnostic_enable_underline = 1
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 1

" -------------------------
" NERDCommenter
" -------------------------

let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = {
\	'js': { 'left': '/* ','right': ' */' }
\}

" -------------------------
" NERDTree
" -------------------------

let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinPos='right'
let g:NERDTreeWinSize=40
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_nerdtree = 1

" -------------------------
" Snippets
" -------------------------

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let s:config_path = fnamemodify(expand($MYVIMRC), ':p:h')
let g:neosnippet#snippets_directory = s:config_path.'/my-snippets'

" -------------------------
" vimtex
" -------------------------

let g:tex_flavor = 'latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_open_on_warning=0


" =========================
" Functions
" =========================

function! ToggleNERDTree()
	if exists('g:NERDTree') && g:NERDTree.IsOpen()
		NERDTreeClose
	else
		try
			NERDTreeFind %
		catch
			NERDTree
		endtry
	endif
endfunction


" =========================
" Key mappings
" =========================

" Save
nmap s :w<cr>
" Redo
nmap U <C-R>

" Remove highlighting
nmap <leader>n :noh<cr>

" Sort visually selected lines
vmap s :sort<cr>

" Copy visual selection to system clipboard
vmap sy "*y

" Reload init.vim
nmap <C-l> :source $MYVIMRC<cr>

" Unmap ex mode
nnoremap Q <Nop>

" Close buffer
nmap QQ :BD<cr>
tmap QQ :bd!<cr>

" Toggle soft wrap
nmap W :set wrap!<cr>

" Close all buffers but the current
command! CloseOthers execute '%bdelete|edit #'
nmap <leader>co :CloseOthers<cr>

" Alt+Backspace deletes an entire word
cmap <A-BS> <C-W>

" -------------------------
" Movement
" -------------------------

" Move faster
nmap J 5j
nmap K 5k
vmap J 5j
vmap K 5k

" Move visually selected block
vmap <c-j> <plug>MoveBlockDown
vmap <c-k> <plug>MoveBlockUp

" -------------------------
" Panes
" -------------------------

" Split current pane
nmap <leader>sv :vs<cr>
nmap <leader>sh :split<cr>

" Move between panes
nmap <up> <c-w>k
nmap <down> <c-w>j
nmap <left> <c-w>h
nmap <right> <c-w>l

" Resize panes
nmap <s-up> :resize -5<cr>
nmap <s-down> :resize +5<cr>
nmap <s-left> :vertical resize -5<cr>
nmap <s-right> :vertical resize +5<cr>

" -------------------------
" Plugins
" -------------------------

" Diagnostics
nmap <leader>dd :OpenDiagnostic<cr>
nmap <leader>dn :NextDiagnosticCycle<cr>
nmap <leader>dp :PrevDiagnosticCycle<cr>

" Telescope
nmap <silent> <leader>l	:Lines<cr>
nmap <silent> <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>

nmap <silent> <space> <cmd>BufstopFast<cr>

" git blame on current line
nmap <leader>b :GitBlame<cr>

" Grep search
nmap gs <plug>(GrepperOperator)

" LSP
nmap <silent> R <cmd>lua vim.lsp.buf.rename()<cr>
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nmap <silent> td <cmd>lua vim.lsp.buf.type_definition()<cr>
nmap <silent> H <cmd>lua vim.lsp.buf.hover()<cr>
nmap <silent> E <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nmap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>

" Snippets
imap <expr><tab> neosnippet#expandable_or_jumpable()
\	? "\<plug>(neosnippet_expand_or_jump)"
\	: "\<tab>"

" Toggle comment for line/selection
nmap <leader>c<space> <plug>NERDCommenterToggle
vmap <leader>c<space> <plug>NERDCommenterToggle

" Toggle file explorer
nmap <silent> <leader><space> :call ToggleNERDTree()<cr>


" =========================
" Highlightning
" =========================

" -------------------------
" Diagnostics
" -------------------------

hi! link LspDiagnosticsError ALEErrorSign
hi! link LspDiagnosticsHint Comment
hi! link LspDiagnosticsInformation Comment
hi! link LspDiagnosticsWarning ALEWarningSign

call sign_define(
\	"LspDiagnosticsErrorSign",
\	{"text" : "", "texthl" : "ALEErrorSign"}
\)
call sign_define(
\	"LspDiagnosticsHintSign",
\	{"text" : "ﯧ", "texthl" : "ALEWarningSign"}
\)
call sign_define(
\	"LspDiagnosticsInformationSign",
\	{"text" : "כֿ", "texthl" : "ALEWarningSign"}
\)
call sign_define(
\	"LspDiagnosticsWarningSign",
\	{"text" : "", "texthl" : "ALEWarningSign"}
\)


" =========================
" Auto commands
" =========================

" Restore position in closed buffers
autocmd BufReadPost * silent! normal! g`"zv

" Read all header files as C headers, not C++
autocmd BufRead,BufNewFile *.h setlocal filetype=c

autocmd FileType c,cpp unmap <s-tab>
autocmd FileType c,cpp nmap <s-tab> :ClangdSwitchSourceHeader<cr>
autocmd FileType cmake,dosini setlocal nolinebreak nowrap
