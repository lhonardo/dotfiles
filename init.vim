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
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
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
set splitright              " Split windows to the right

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files follow=true<cr>
nnoremap <leader>fg <cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ follow=true })<cr>
nnoremap <leader>fb <cmd>Telescope buffers follow=true<cr>
nnoremap <leader>fs <cmd>Telescope lsp_document_symbols follow=true<cr>
nnoremap <leader>fh <cmd>Telescope help_tags follow=true<cr>
nnoremap <leader>fw <cmd>Telescope grep_string follow=true<cr>
nnoremap <leader>fr <cmd>Telescope resume follow=true<cr>
nnoremap <leader>fi <cmd>AdvancedGitSearch<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fu <cmd>Telescope undo<cr>
nnoremap <leader>fy <cmd>Telescope neoclip<cr>

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
 Plug 'nvim-telescope/telescope-live-grep-args.nvim'
 Plug 'aaronhallaert/advanced-git-search.nvim'
 Plug 'debugloop/telescope-undo.nvim'
 Plug 'AckslD/nvim-neoclip.lua'
Plug 'kkharji/sqlite.lua'
call plug#end()

colorscheme everforest

lua << EOF
local actions = require('telescope.actions')
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
            }
        }
    },
    extensions = {
      live_grep_args = {},
      advanced_git_search = {}
    }
  }
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("advanced_git_search")
require("telescope").load_extension("undo")
require('neoclip').setup({
  history = 1000,
  enable_persistent_history = true,
  continuous_sync = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-k>',
        replay = '<c-q>',  -- replay a macro
        delete = '<c-d>',  -- delete an entry
      },
    }
  }
})
require('telescope').load_extension('neoclip')
EOF
