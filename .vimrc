" Disable Vi compatibility mode to enable full Vim features
set nocompatible

" Set leader key to space
let mapleader = " "

" Map ZWNJ to space in insert mode
inoremap <Char-0x200C> <Space>

" Performance tweaks
set lazyredraw      " Improve scrolling performance
set updatetime=300  " Faster UI updates

" By default timeoutlen is 1000 ms
set timeoutlen=150

" Use the system clipboard for all yank, delete, paste operations automatically
set clipboard=unnamed,unnamedplus

" Remove ~ symbols on empty lines globally
set fillchars+=eob:\ 

" Show partial commands in the bottom right (e.g., after typing ':')
set showcmd

" Set terminal colors to 256-color mode (useful for modern terminals)
set t_Co=256
set term=screen-256color

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
if has("termguicolors")
  set termguicolors
endif

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
nnoremap <silent> <leader>nl :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Center the screen after jumping
nnoremap n nzz
nnoremap N Nzz

" Exit insert mode by pressing 'kj'
inoremap kj <Esc>

" Exit visual mode by pressing 'TAB'
vnoremap <Tab> <Esc>



" Buffer navigation and management

" Go to the next buffer
nnoremap <leader>bn :bnext<CR>

" Go to the previous buffer
nnoremap <leader>bp :bprevious<CR>

" Save the current buffer
nnoremap <leader>bw :w<CR>

" Save all open buffers
nnoremap <leader>bW :wall<CR>

" Delete the current buffer
nnoremap <leader>bd :bdelete<CR>

" Force delete the current buffer without saving
nnoremap <leader>bD :bdelete!<CR>

" Close all buffers except the current one
function! CloseOtherBuffers()
let curr = bufnr('%')
let to_delete = []

" Collect buffers to delete
for b in range(1, bufnr('$'))
if buflisted(b) && b != curr
  call add(to_delete, b)
endif
endfor

" If there are buffers to delete, ask for confirmation
if !empty(to_delete)
let confirm_msg = 'Delete ' . len(to_delete) . ' buffer(s)?'
if confirm(confirm_msg, "&Yes\n&No", 2) != 1
  return
endif

" Delete the buffers one by one with confirmation
for b in to_delete
  execute 'confirm bdelete ' . b
endfor
endif
endfunction

nnoremap <leader>bo :call CloseOtherBuffers()<CR>



" Window navigation and management

" close the current window
nnoremap <leader>wc :close<CR>

" Force close the current window (discard changes)
nnoremap <leader>wC :close!<CR>

" Create a horizontal split
nnoremap <Leader>sh :split<CR>

" Create a vertical split
nnoremap <Leader>sv :vsplit<CR>

" Navigate between splits using Ctrl + {h,j,k,l}
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Force quit the current window without saving
nnoremap <leader>Q :q!<CR>



" Open .vimrc for editing
nnoremap <leader>ev :e $MYVIMRC<CR>



" Tab navigation and management

" Go to the next tab
nnoremap <leader>tn :tabnext<CR>

" Go to the previous tab
nnoremap <leader>tp :tabprevious<CR>

" Go to the first tab
nnoremap <leader>tf :tabfirst<CR>

" Go to the last tab
nnoremap <leader>tl :tablast<CR>

" Close the current tab
nnoremap <leader>tc :tabclose<CR>

" Close the current tab
nnoremap <leader>tC :tabclose!<CR>

call plug#begin('~/.vim/plugged')
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'rakr/vim-one'
Plug 'ghifarit53/tokyonight-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Plug 'kshenoy/vim-signature'
" Plug 'tpope/vim-surround'
call plug#end()

" Vim signature configuration
" nnoremap <leader>m] ]`zz
" nnoremap <leader>m[ [`zz

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

" Center the screen after cursor moved
function! s:CenterAfterJump()
  augroup CenterAfterJump
    autocmd!
    autocmd CursorMoved * ++once normal! zz
  augroup END
endfunction

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
  autocmd BufWritePre *.cpp,*.hpp,*.c,*.h,*.json,*.yaml silent! call CocAction('format')
augroup end

" Code actions (selected, cursor, and source)
xnoremap <leader>ca  <Plug>(coc-codeaction-selected)
nnoremap <leader>ca  <Plug>(coc-codeaction-selected)
nnoremap <leader>cc  <Plug>(coc-codeaction-cursor)
nnoremap <leader>cs  <Plug>(coc-codeaction-source)

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
nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" Restart coc.nvim
nnoremap <silent> <leader>cr :CocRestart<CR>

" fzf.vim configuration

" Initialize configuration dictionary
let g:fzf_vim = {}

let g:fzf_layout = {
      \ 'window': {
      \   'width': 0.7,
      \   'height': 0.6,
      \   'relative': v:true,
      \   'border': 'sharp'
      \ }
      \}
let g:fzf_vim.preview_window = ['right:50%:border-sharp', 'ctrl-/']

let g:fzf_vim.tags_command = 'ctags -R --languages=C++ --fields=+l --extras=+q'

" Fuzzy find files in the current directory
nnoremap <Leader>sf :Files<CR> 

" Fuzzy find git-tracked files
nnoremap <Leader>sg :GFiles<CR>

" Switch between open buffers
nnoremap <Leader>sb :Buffers<CR>

" Search inside current buffer
nnoremap <Leader>sl :BLines<CR>

" Search across project
nnoremap <Leader>sp :Rg<CR>

" Fuzzy find tags
nnoremap <Leader>st :Tags<CR>

" Jump to marks
nnoremap <Leader>sm :Marks<CR>

" Recently used files
nnoremap <Leader>sr :History<CR>

" Fuzzy find commands
nnoremap <Leader>sc :Commands<CR>

colorscheme catppuccin_mocha

let g:transparent_enabled = 1

" Function to toggle transparency
function! ToggleTransparency()
  if g:transparent_enabled
    colorscheme catppuccin_mocha
    let g:transparent_enabled = 0
  else
    " Make main editing area, inactive windows, sign column, splits, line numbers, folds, and non-text fully transparent
    highlight Normal       guibg=NONE ctermbg=NONE
    highlight Visual       gui=NONE   guibg=#4f5368 guifg=NONE
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

    let g:transparent_enabled = 1
  endif
endfunction

" Define a user command :ToggleTransparency that calls ToggleTransparency()
command! ToggleTransparency call ToggleTransparency()

autocmd VimEnter * call ToggleTransparency()

" Add a space character as the vertical separator (column between splits)
" This overrides the default '|' split bar with a blank space
:set fillchars+=vert:\ 

" Remove any special styling (like reverse or bold) from vertical splits
" This makes the split line visually minimal when combined with the blank `fillchars`
highlight VertSplit cterm=NONE

" Function to generate a list of all relevant Vim register names
function! s:GetRegisterList()
  " Generate lowercase letters a-z as string
  let lower   = join(map(range(char2nr('a'), char2nr('z')), {_, v -> nr2char(v)}), '')
  " Generate uppercase letters A-Z as string
  let upper   = join(map(range(char2nr('A'), char2nr('Z')), {_, v -> nr2char(v)}), '')
  " Generate digits 0-9 as string
  let digits  = join(map(range(0, 9), {_, v -> string(v)}), '')
  " Special registers commonly used let special = '"*-+'

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

highlight TabLineSel  guibg=#313244 guifg=#cdd6f4 gui=bold
highlight TabLine     guibg=#1e1e2e guifg=#585b70
highlight TabLineFill guibg=#1e1e2e guifg=#585b70

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    if tabnr == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let buflist = tabpagebuflist(tabnr)
    let winnr = tabpagewinnr(tabnr)
    let bufname = bufname(buflist[winnr - 1])
    if bufname == ''
      let bufname = '[No Name]'
    else
      let bufname = fnamemodify(bufname, ':t')
    endif
    let s .= '   ' . tabnr . ': ' . bufname . ' '
  endfor
  let s .= '%#TabLineFill#%='
  return s
endfunction

set showtabline=1
set tabline=%!MyTabLine()


 
" Statusline

" Colors
let g:StslineColorGreen  = "#A6E3A1"
let g:StslineColorBlue   = "#89B4FA"
let g:StslineColorViolet = "#CBA6F7"
let g:StslineColorYellow = "#F9E2AF"
let g:StslineColorOrange = "#FAB387"

let g:StslineColorLight  = "#CDD6F4"
let g:StslineColorDark   = "#11111B"
let g:StslineColorDark1  = "#181825"
let g:StslineColorDark2  = "#1E1E2E"
let g:StslineColorDark3  = "#313244"

let g:StslineBackColor   = g:StslineColorDark2
let g:StslineOnBackColor = g:StslineColorLight
let g:StslineOnPriColor  = g:StslineColorDark
let g:StslineSecColor    = g:StslineColorDark3
let g:StslineOnSecColor  = g:StslineColorLight

execute 'highlight StslineSecColorFG guifg=' . g:StslineSecColor   ' guibg=' . g:StslineBackColor
execute 'highlight StslineSecColorBG guifg=' . g:StslineColorLight ' guibg=' . g:StslineSecColor
execute 'highlight StslineBackColorBG guifg=' . g:StslineColorLight ' guibg=' . g:StslineBackColor
execute 'highlight StslineBackColorFGSecColorBG guifg=' . g:StslineBackColor ' guibg=' . g:StslineSecColor
execute 'highlight StslineSecColorFGBackColorBG guifg=' . g:StslineSecColor ' guibg=' . g:StslineBackColor
execute 'highlight StslineModColorFG guifg=' . g:StslineColorYellow ' guibg=' . g:StslineBackColor
 
" Enable statusline
set laststatus=2
 
" Disable showmode - i.e. Don't show mode like --INSERT-- in current statusline.
set noshowmode
 
" Define active statusline
function! ActivateStatusline()
call GetFileType()
setlocal statusline=%#StslinePriColorBG#\ %{StslineMode()}%#StslineSecColorBG#%{get(b:,'coc_git_status',b:GitBranch)}%{get(b:,'coc_git_blame','')}%#StslineBackColorFGPriColorBG#%#StslinePriColorFG#\ %{&readonly?\"\ \":\"\"}%F\ %#StslineModColorFG#%{&modified?\"\ \":\"\"}%=%#StslinePriColorFG#\ %{b:FiletypeIcon}%{&filetype}\ %#StslineSecColorFG#%#StslineSecColorBG#%{&fenc!='utf-8'?\"\ \":''}%{&fenc!='utf-8'?&fenc:''}%{&fenc!='utf-8'?\"\ \":''}%#StslinePriColorFGSecColorBG#%#StslinePriColorBG#\ %p\%%\ %#StslinePriColorBGBold#%l%#StslinePriColorBG#/%L\ :%c\ 
endfunction
 
" Define Inactive statusline
 function! DeactivateStatusline()
 
if !exists("b:GitBranch") || b:GitBranch == ''
setlocal statusline=%#StslineSecColorBG#\ INACTIVE\ %#StslineSecColorBG#%{get(b:,'coc_git_statusline',b:GitBranch)}%{get(b:,'coc_git_blame','')}%#StslineBackColorFGSecColorBG#%#StslineBackColorBG#\ %{&readonly?\"\ \":\"\"}%F\ %#StslineModColorFG#%{&modified?\"\ \":\"\"}%=%#StslineBackColorBG#\ %{b:FiletypeIcon}%{&filetype}\ %#StslineSecColorFGBackColorBG#%#StslineSecColorBG#\ %p\%%\ %l/%L\ :%c\ 
 
else
setlocal statusline=%#StslineSecColorBG#%{get(b:,'coc_git_statusline',b:GitBranch)}%{get(b:,'coc_git_blame','')}%#StslineBackColorFGSecColorBG#%#StslineBackColorBG#\ %{&readonly?\"\ \":\"\"}%F\ %#StslineModColorFG#%{&modified?\"\ \":\"\"}%=%#StslineBackColorBG#\ %{b:FiletypeIcon}%{&filetype}\ %#StslineSecColorFGBackColorBG#%#StslineSecColorBG#\ %p\%%\ %l/%L\ :%c\ 
endif
 
endfunction
 
" Get Statusline mode & also set primary color for that mode
function! StslineMode()
 
    let l:CurrentMode=mode()
 
    if l:CurrentMode==#"n"
        let g:StslinePriColor     = g:StslineColorGreen
        let b:CurrentMode = "NORMAL "
 
    elseif l:CurrentMode==#"i"
        let g:StslinePriColor     = g:StslineColorViolet
        let b:CurrentMode = "INSERT "
 
    elseif l:CurrentMode==#"c"
        let g:StslinePriColor     = g:StslineColorYellow
 
        let b:CurrentMode = "COMMAND "
 
    elseif l:CurrentMode==#"v"
        let g:StslinePriColor     = g:StslineColorBlue
        let b:CurrentMode = "VISUAL "
 
    elseif l:CurrentMode==#"V"
        let g:StslinePriColor     = g:StslineColorBlue
        let b:CurrentMode = "V-LINE "
 
    elseif l:CurrentMode==#"\<C-v>"
        let g:StslinePriColor     = g:StslineColorBlue
        let b:CurrentMode = "V-BLOCK "
 
    elseif l:CurrentMode==#"R"
        let g:StslinePriColor     = g:StslineColorViolet
        let b:CurrentMode = "REPLACE "
 
    elseif l:CurrentMode==#"s"
        let g:StslinePriColor     = g:StslineColorBlue
        let b:CurrentMode = "SELECT "
 
    elseif l:CurrentMode==#"t"
        let g:StslinePriColor     =g:StslineColorYellow
        let b:CurrentMode = "TERM "
 
    elseif l:CurrentMode==#"!"
        let g:StslinePriColor     = g:StslineColorYellow
        let b:CurrentMode = "SHELL "
 
    endif
 
 
    call UpdateStslineColors()
    
    return b:CurrentMode
 
endfunction
 
" Update colors. Recreate highlight groups with new Primary color value.
function! UpdateStslineColors()
 
execute 'highlight StslinePriColorBG           guifg=' . g:StslineOnPriColor ' guibg=' . g:StslinePriColor
execute 'highlight StslinePriColorBGBold       guifg=' . g:StslineOnPriColor ' guibg=' . g:StslinePriColor ' gui=bold'
execute 'highlight StslinePriColorFG           guifg=' . g:StslinePriColor   ' guibg=' . g:StslineBackColor
execute 'highlight StslinePriColorFGSecColorBG guifg=' . g:StslinePriColor   ' guibg=' . g:StslineSecColor
execute 'highlight StslineSecColorFGPriColorBG guifg=' . g:StslineSecColor   ' guibg=' . g:StslinePriColor
 
if !exists("b:GitBranch") || b:GitBranch == ''
execute 'highlight StslineBackColorFGPriColorBG guifg=' . g:StslineBackColor ' guibg=' . g:StslinePriColor
endif
 
endfunction
 
" Get git branch name
function! GetGitBranch()
let b:GitBranch=""
try
    let l:dir=expand('%:p:h')
    let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
    if !v:shell_error
        let b:GitBranch="   ".substitute(l:gitrevparse, '\n', '', 'g')." "
        execute 'highlight StslineBackColorFGPriColorBG guifg=' . g:StslineBackColor ' guibg=' . g:StslineSecColor
    endif
catch
endtry
endfunction
 
" Get filetype & custom icon. Put your most used file types first for optimized performance.
function! GetFileType()
 
if &filetype == 'typescript'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'html'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'scss'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'css'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'javascript'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'javascriptreact'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'markdown'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'sh' || &filetype == 'zsh'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'vim'
let b:FiletypeIcon = ' '
 
elseif &filetype == ''
let b:FiletypeIcon = ''
 
elseif &filetype == 'rust'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'ruby'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'cpp'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'c'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'go'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'lua'
let b:FiletypeIcon = ' '
 
elseif &filetype == 'haskel'
let b:FiletypeIcon = ' '

elseif &filetype == 'coc-explorer'
let b:FiletypeIcon = ' '
 
else
let b:FiletypeIcon = ' '
 
endif
endfunction
 
" Get git branch name after entering a buffer
augroup GetGitBranch
    autocmd!
    autocmd BufEnter * call GetGitBranch()
augroup END
 
" Set active / inactive statusline after entering, leaving buffer
augroup SetStslineline
    autocmd!
    autocmd BufEnter,WinEnter * call ActivateStatusline()
    autocmd BufLeave,WinLeave * call DeactivateStatusline()
augroup END

" coc-explorer configs

" Use <Leader>e to toggle explorer
:nmap <space>fe <Cmd>CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nmap <space>ed <Cmd>CocCommand explorer --preset .vim<CR>
nmap <space>ec <Cmd>CocCommand explorer --preset cocConfig<CR>
nmap <space>eb <Cmd>CocCommand explorer --preset buffer<CR>

function! s:explorer_cur_dir()
  let node_info = CocAction('runCommand', 'explorer.getNodeInfo', 0)
  return fnamemodify(node_info['fullpath'], ':h')
endfunction

function! s:exec_cur_dir(cmd)
  let dir = s:explorer_cur_dir()
  execute 'cd ' . dir
  execute a:cmd
endfunction

function! s:init_explorer()
  " Integration with other plugins

  " CocList
  nmap <buffer> <Leader>fg <Cmd>call <SID>exec_cur_dir('CocList -I grep')<CR>
  nmap <buffer> <Leader>fG <Cmd>call <SID>exec_cur_dir('CocList -I grep -regex')<CR>
  nmap <buffer> <C-p> <Cmd>call <SID>exec_cur_dir('CocList files')<CR>

  " vim-floaterm
  nmap <buffer> <Leader>ft <Cmd>call <SID>exec_cur_dir('FloatermNew --wintype=floating')<CR>
endfunction

function! s:enter_explorer()
  if &filetype == 'coc-explorer'
    " statusline
    setl statusline=coc-explorer
  endif
endfunction

augroup CocExplorerCustom
  autocmd!
  autocmd BufEnter * call <SID>enter_explorer()
  autocmd FileType coc-explorer call <SID>init_explorer()
augroup END

" Which key configs
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
