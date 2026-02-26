local opt = vim.opt

opt.completeopt = { "menu", "menuone", "noselect" }
opt.termguicolors = true

opt.clipboard = "unnamedplus"
opt.signcolumn = "yes:1"

opt.number = true
opt.relativenumber = true
opt.linebreak = true
opt.showbreak = "+++"
opt.textwidth = 80
opt.showmatch = true
opt.visualbell = true

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.ruler = true
opt.undolevels = 1000
opt.backspace = { "indent", "eol", "start" }

opt.hidden = true
opt.backup = false
opt.writebackup = false

opt.updatetime = 300
opt.shortmess:append("c")
opt.scrolloff = 5
