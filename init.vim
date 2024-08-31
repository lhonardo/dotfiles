set background=dark
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
"set clipboard=unnamedplus   " using system clipboard
filetype plugin on
"set cursorline              " highlight current cursorline
set ruler                   " Show file stats
set ttyfast                 " Speed up scrolling in Vim
set visualbell              " Blink cursor instead of beeping
set spell                 " enable spell check (may need to download language package)
"set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.
set colorcolumn=            " Disable vertical center line

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

call plug#begin()
 Plug 'gilgigilgil/anderson.vim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'hashivim/vim-terraform'
 "Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'github/copilot.vim'
 Plug 'zbirenbaum/copilot.lua'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
call plug#end()

colorscheme anderson

lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF
