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

let g:python3_host_prog = expand('~/.local/share/nvim/venv/bin/python3')

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
 Plug 'greggh/claude-code.nvim'
call plug#end()

colorscheme everforest

lua << EOF
local actions = require('telescope.actions')
require("claude-code").setup({
  -- Terminal window settings
  window = {
    split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
    position = "botright",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
    enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
    hide_numbers = true,    -- Hide line numbers in the terminal window
    hide_signcolumn = true, -- Hide the sign column in the terminal window

    -- Floating window configuration (only applies when position = "float")
    float = {
      width = "80%",        -- Width: number of columns or percentage string
      height = "80%",       -- Height: number of rows or percentage string
      row = "center",       -- Row position: number, "center", or percentage string
      col = "center",       -- Column position: number, "center", or percentage string
      relative = "editor",  -- Relative to: "editor" or "cursor"
      border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
    },
  },
  -- File refresh settings
  refresh = {
    enable = true,           -- Enable file change detection
    updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
    timer_interval = 1000,   -- How often to check for file changes (milliseconds)
    show_notifications = true, -- Show notification when files are reloaded
  },
  -- Git project settings
  git = {
    use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
  },
  -- Shell-specific settings
  shell = {
    separator = '&&',        -- Command separator used in shell commands
    pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
    popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
  },
  -- Command settings
  command = "claude",        -- Command used to launch Claude Code
  -- Command variants
  command_variants = {
    -- Conversation management
    continue = "--continue", -- Resume the most recent conversation
    resume = "--resume",     -- Display an interactive conversation picker

    -- Output options
    verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
  },
  -- Keymaps
  keymaps = {
    toggle = {
      normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
      terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
      variants = {
        continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
        verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
      },
    },
    window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
    scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
  }
})
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
