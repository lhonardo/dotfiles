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
filetype plugin on
"set cursorline              " highlight current cursorline
set ruler                   " Show file stats
set ttyfast                 " Speed up scrolling in Vim
set visualbell              " Blink cursor instead of beeping
set spell                 " enable spell check (may need to download language package)
"set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.
set colorcolumn=            " Disable vertical center line
set clipboard=unnamedplus   " Use system clipboard

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'

" Customize highlight groups for the signs in the sign column
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

call plug#begin()
 Plug 'hashivim/vim-terraform'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'zbirenbaum/copilot.lua'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
 Plug 'airblade/vim-gitgutter'
 "Colorschemes
 Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
 Plug 'ryanoasis/vim-devicons'
 Plug 'neanias/everforest-nvim', { 'branch': 'main' }
call plug#end()

colorscheme everforest

lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF
