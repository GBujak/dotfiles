call plug#begin('~/.vim/plugged')
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'windwp/nvim-autopairs'

Plug 'RRethy/nvim-base16'
Plug 'Mofiqul/adwaita.nvim'

Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'folke/trouble.nvim'
call plug#end()

" completion
set completeopt=menu,menuone,noselect

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
    },
})
EOF

lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for index,serverName in pairs(require'mason-lspconfig'.get_installed_servers()) do
    require('lspconfig')[serverName].setup { capabilities = capabilities }
end
EOF

" --------------------> autopairs

lua << EOF
require("nvim-autopairs").setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
EOF

" ---------------> My bindings <---------------

let mapleader = ' '
nnoremap <leader>z :GFiles --exclude-standard -o -c<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>B :w<CR>:bd<CR>
nnoremap <leader>O :wa<CR>:%bd<CR>

nnoremap gn :bnext<CR>
nnoremap gN :bprevious<CR>

" Terminal emulator
lua << EOF
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("toggleterm").setup{}
EOF

nnoremap <leader>t :ToggleTerm size=80 direction=vertical<CR>

" --------------------> Buffer line

lua << EOF
require("bufferline").setup{}
EOF

" NERD Tree

lua << EOF
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            }
        }
    }
})
EOF

" --------------------> Diagnostics

lua << EOF
require("trouble").setup{}
EOF

nnoremap <leader>T :NvimTreeFindFileToggle<CR>

" --------------------> Theme

let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
set termguicolors
set background=dark "<-- toggle theme

" --------------------> Misc config

colorscheme adwaita

" make system copy buffer the default
set clipboard=unnamedplus

" Sign column always shown
:set signcolumn=yes:1

" General
set number relativenumber	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=80	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs

set shiftwidth=4	" Number of auto-indent spaces
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
  autocmd FileType markdown setlocal textwidth=80
augroup end

" Syntax concealing
" set conceallevel=2

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
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_prev()<CR>

" Auto formatting
autocmd BufWritePre *.js lua vim.lsp.buf.formatting()
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting()
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting()
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting()
autocmd BufWritePre *.vue lua vim.lsp.buf.formatting()
autocmd BufWritePre *.py lua vim.lsp.buf.formatting()
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting()
autocmd BufWritePre *.kt lua vim.lsp.buf.formatting()

" Web indentation
autocmd BufNewFile,BufReadPre,FileReadPre  *.html     setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.css      setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.ts       setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.tsx      setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.js       setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.jsx      setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.vue      setlocal shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufReadPre,FileReadPre  *.svelte   setlocal shiftwidth=2 softtabstop=2

" Scrollbar configuration
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end
" End Scrollbar configuration
