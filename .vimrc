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
set encoding=utf-8

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

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

call plug#begin('~/.vim/plugged')
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" coc.nvim configuration
"
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nnoremap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nnoremap <silent><nowait> gd <Plug>(coc-definition)
nnoremap <silent><nowait> gy <Plug>(coc-type-definition)
nnoremap <silent><nowait> gi <Plug>(coc-implementation)
nnoremap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
if CocAction('hasProvider', 'hover')
call CocActionAsync('doHover')
else
call feedkeys('K', 'in')
endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)

" LSP formatting
nnoremap <silent> <leader>f :call CocAction('format')<CR>

" Fallback: Manual clang-format (uncomment if needed)
" nnoremap <silent> <leader>f :silent keepjumps %!clang-format<CR>

" Auto-format on save (with error handling)
augroup autoformat_cpp
  autocmd!
  autocmd BufWritePre *.cpp,*.hpp,*.c,*.h silent! call CocAction('format')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
" xnoremap <leader>a  <Plug>(coc-codeaction-selected)
" nnoremap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nnoremap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nnoremap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nnoremap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nnoremap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xnoremap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nnoremap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nnoremap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" Restart coc.nvim
nnoremap <silent> <leader>cr :CocRestart<CR>

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

" Popup menu (completion list)
highlight Pmenu        guibg=#1e1e2e guifg=#cdd6f4
highlight PmenuSel     guibg=#585b70 guifg=#f5e0dc
highlight PmenuThumb   guibg=#45475a
highlight PmenuSbar    guibg=#313244

" Coc.nvim floating window and menu selection
highlight CocFloating  guibg=#1e1e2e guifg=#cdd6f4
highlight CocMenuSel   guibg=#585b70 guifg=#f5e0dc

" Coc.nvim specific popup menu elements
highlight PmenuKind    guifg=#89b4fa
highlight PmenuExtra   guifg=#f2cdcd

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

