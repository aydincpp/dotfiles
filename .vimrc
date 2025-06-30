" Disable Vi compatibility mode to enable full Vim features
set nocompatible

" Set leader key to space
let mapleader = " "

" Performance tweaks
set lazyredraw      " Improve scrolling performance
set updatetime=300  " Faster UI updates

" Use the system clipboard for all yank, delete, paste operations automatically
set clipboard=unnamed,unnamedplus

" Show partial commands in the bottom right (e.g., after typing ':')
set showcmd

" Set terminal colors to 256-color mode (useful for modern terminals)
set t_Co=256

" Use UTF-8 encoding for all file operations and display
set encoding=UTF-8

" Do not wrap long lines; let lines scroll horizontally
set nowrap

" Show absolute line numbers on the left
set number

" Show relative line numbers relative to the cursor position
set relativenumber

" Do not highlight the current cursor line
set nocursorline

" Enable filetype detection and plugins for better language support
filetype plugin off

" syntax highlighting
syntax on

" Terminal GUI colors
set termguicolors

" Set the number of spaces that a <Tab> counts for
set tabstop=4

" Set the number of spaces a <Tab> inserts while editing (soft tab)
set softtabstop=4

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Use spaces instead of literal tab characters when indenting
set expandtab

" Copy indent from current line when starting a new line
set autoindent

" Enable C-style indentation rules
set cindent

" Enable smart indentation (better automatic indentation)
set smartindent

" Briefly jump to matching bracket when inserting a bracket
set showmatch

" Incremental search: show matches as you type search pattern
set incsearch

" Highlight all matches of the last search pattern
set hlsearch   

" Ignore case in search patterns
set ignorecase

" Disable swap files to avoid cluttering disk with `.swp` files
set noswapfile

" Allow backspace over indent, line breaks, and start of insert
set backspace=indent,eol,start

" Open new horizontal splits below the current window
set splitbelow

" Open new vertical splits to the right of the current window
set splitright

" Scroll the screen horizontally by n column at a time when cursor moves off-screen
set sidescroll=1

" Keep at least n columns visible to the left/right of the cursor during horizontal scrolling
set sidescrolloff=5

" Delete comment character when joining commented lines.
set formatoptions+=j

" Show popup menu for completions
set completeopt=menuone,noselect

" Saving options in session and view files causes more problems than it
" solves, so disable it.
set sessionoptions-=options
set viewoptions-=options

" Disable a legacy behavior that can break plugin maps.
set nolangremap

" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif

" Enable the :Man command shipped inside Vim's man filetype plugin.
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man' && !has('nvim')
  runtime ftplugin/man.vim
endif

" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
" :diffupdate.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Smart <Tab> file path popup in insert mode
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : (getline('.')[col('.')-2] =~ '[/~]' ? "\<C-x>\<C-f>" : "\<Tab>")

" Exit insert mode by pressing 'kj' inoremap kj <Esc>
inoremap kj <Esc>

" Exit visual mode by pressing 'TAB'
vnoremap <Tab> <Esc>

" Fast saving
nnoremap <leader>w :w<CR>

" Fast quitting
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Better buffer switching
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>

" Open .vimrc for quick editing and reloading
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Format the current buffer with clang-format
nnoremap <silent> <F3> :%!clang-format<CR>

autocmd FileType cpp,c,h,hpp nnoremap <buffer> <F3> :%!clang-format<CR>
autocmd BufWritePre *.cpp,*.hpp,*.cc,*.h :silent! execute ':%!clang-format'

call plug#begin('~/.vim/plugged')
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

" Colorscheme
colorscheme catppuccin_mocha

" Make main editing area, inactive windows, sign column, splits, line numbers, folds, and non-text fully transparent
highlight Normal       guibg=NONE ctermbg=NONE
highlight NormalNC     guibg=NONE ctermbg=NONE
highlight SignColumn   guibg=NONE ctermbg=NONE
highlight VertSplit    guibg=NONE ctermbg=NONE
highlight LineNr       guibg=NONE ctermbg=NONE
highlight Folded       guibg=NONE ctermbg=NONE
highlight NonText      guibg=NONE ctermbg=NONE

" Match line number foreground to normal text
highlight LineNr       guibg=NONE guifg=fg

" Set visual selection background (no bold, no foreground change)
highlight Visual       cterm=NONE ctermbg=236 ctermfg=NONE
highlight Visual       gui=NONE  guibg=#4f5368 guifg=NONE

" Function to generate a list of all relevant Vim register names
function! s:GetRegisterList()
  " Generate lowercase letters a-z as string
  let lower   = join(map(range(char2nr('a'), char2nr('z')), {_, v -> nr2char(v)}), '')
  " Generate uppercase letters A-Z as string
  let upper   = join(map(range(char2nr('A'), char2nr('Z')), {_, v -> nr2char(v)}), '')
  " Generate digits 0-9 as string
  let digits  = join(map(range(0, 9), {_, v -> string(v)}), '')
  " Special registers commonly used
  let special = '"*-+'

  " Combine all into a list of single-character register names
  return split(lower . upper . digits . special, '\zs')
endfunction

" Define a user command :ClearRegisters that calls ClearAllRegisters()
command! ClearRegisters call ClearAllRegisters()

" Function to clear all non-empty registers returned by s:GetRegisterList()
function! ClearAllRegisters()
  " Iterate over each register
  for r in s:GetRegisterList()
    " If register is not empty, clear it
    if getreg(r) !=# ''
      call setreg(r, '')
    endif
  endfor
  " Also clear the search register '/' if it holds a pattern
  if getreg('/') !=# ''
    let @/ = ''
  endif
endfunction

