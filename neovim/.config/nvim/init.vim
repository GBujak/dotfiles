call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox',
Plug 'arcticicestudio/nord-vim',

Plug 'cohama/lexima.vim',
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig',
Plug 'hrsh7th/nvim-compe',

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim',

Plug 'kassio/neoterm',
Plug 'plasticboy/vim-markdown',

call plug#end()

" ---------------> My bindings <---------------

let mapleader = ' '
nnoremap <leader>z :GFiles --exclude-standard -o -c<CR>

" Terminal emulator
nnoremap <leader>t :split<CR><C-w>j:Topen<CR>i
tnoremap <ESC> <C-\><C-n>:q<CR>

" ---------------> My bindings <---------------

" Theme
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'hard'
set termguicolors
let g:gruvbox_italic=1
set background=light "<-- toggle theme
colorscheme gruvbox

" General
set number relativenumber	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
 
" Advanced
set ruler	" Show row and column ruler information
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Markown configuration
" Line wrapping
augroup auFileTypes
  autocmd!
  autocmd FileType markdown setlocal textwidth=85
augroup end

" Syntax concealing
set conceallevel=2

" Other
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
" Follow links that lead to non-markdown files
let g:vim_markdown_no_extensions_in_markdown = 1

" Don't insert bullet points or indent (for text wrapping)
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" Treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = false
  },
}
EOF

" Folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" End Treesitter config

" Lsp config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

nnoremap <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>

" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

" Auto formatting
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

" Setup language servers
lua << EOF
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}
EOF
" End Lsp config


" Compe config
" Required for Compe to work
set completeopt=menuone,noselect

" Configuration
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = true;
  };
}
EOF

" Key bindings
" NOTE: Order is important. You can't lazy loading lexima.vim.
let g:lexima_no_default_rules = v:true
let g:lexima_enable_newline_rules = 1
call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" End Compe config
