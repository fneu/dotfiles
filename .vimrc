" vim configuration by Fabian Neuschmidt

filetype plugin indent on
syntax enable

" VIM-PLUG
" automatic install on first use
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
    let g:first_use = "yes"
endif

" PLUGINS

call plug#begin()

" colorscheme
Plug 'fneu/breezy'

" tools / editing
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'             " fzf integration for vim
Plug 'tpope/vim-fugitive'           " git integration
Plug 'tpope/vim-commentary'         " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'           " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'             " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'            " netrw improvements
Plug 'tpope/vim-unimpaired'         " various ]/[ bindings
Plug 'tpope/vim-eunuch'             " :SudoWrite, :Unlink, :Rename, ...
Plug 'tpope/vim-abolish'            " Case aware replace; crs, crm, etc. for casing
Plug 'wincent/terminus'             " FocusGained, cursor shape, bracketed paste
Plug 'ap/vim-css-color'             " highlight colors in various file types
Plug 'github/copilot.vim'           " AI autocompletion
Plug 'DanBradbury/copilot-chat.vim' " AI chat interface

" languages
Plug 'Vimjas/vim-python-pep8-indent' " PEP8 conform indenting
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'HerringtonDarkholme/yats.vim' " TypeScript Syntax
Plug 'othree/html5.vim'             " Html5 Syntax
Plug 'othree/yajs.vim'              " JavaScript Syntax
Plug 'OmniSharp/omnisharp-vim'      " C# IDE features via OmniSharp-roslyn
" completion / LSP
"
" https://github.com/dense-analysis/ale/pull/5078
Plug 'dense-analysis/ale'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

" Features
Plug 'vim-test/vim-test'  " pytest
Plug 'lervag/wiki.vim'
Plug 'sharat87/roast.vim' " http requests
Plug 'puremourning/vimspector'      " debugger (C# needs :VimspectorInstall netcoredbg)

call plug#end()

packadd! matchit

" BASIC SETUP

set autoindent                      " carry over indent to next line
set backspace=indent,eol,start      " backspace over everything
set complete-=i                     " no included files in keyword completion
set smarttab                        " use shiftwidth for tab/space indentation

set tabstop=8                       " size of actual tab chars
set softtabstop=4                   " 'width' of a tab inserting operation
set shiftwidth=4                    " 'width' of an indenting operation
set expandtab                       " indent using spaces instead of tabs

set incsearch                       " preview position of first search match
set hlsearch                        " highlight search matches
set ignorecase                      " case insensitive search ...
set smartcase                       " ... unless pattern contains capitals

set nrformats-=octal                " prevent <C-A> from skipping 8 and 9

set ttimeout                        " don't wait forever on key codes like esc
set ttimeoutlen=100
set updatetime=400                  " timeout for cursorhold

set shortmess+=c                    " suppress ins-complete-menu messages
set noshowmode                      " suppress mode messages -> use for ale signature help
set wildmenu                        " command line completion
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set ruler                           " show current position in statusline

set scrolloff=3                     " always show n lines above/below cursor
set sidescrolloff=5
set display+=lastline               " show part of long last line (and marker)

set encoding=utf-8
set showbreak=↪\                    " continuation after wrapped lines
set listchars=tab:→\ ,nbsp:␣,trail:·,extends:›,precedes:‹
set list                            " highlight above chars respectively
set formatoptions+=j                " delete comment char when joining lines

set autoread                        " auto load file changes, needs terminus

set history=1000                    " command-line history
set nobackup                        " no file.txt~ backup of last written save
set noswapfile                      " no .swp created while editing

set belloff=all                     " no terminal visual bell

set hidden                          " allow leaving unsaved buffer (gd)

if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile                        " keep undo history (forever)

set mouse=a                         " use mouse in all modes
set clipboard=unnamed,unnamedplus   " use system clipboard

set foldmethod=indent               " fold by indent, overridden later per filetype
set foldlevel=99                    " start with all folds open

" VISUAL

" for vim 7
set t_Co=255

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" gvim font and ui
if has("gui_running")
    set guifont=Berkeley\ Mono:h11
    if has("win32")
        " set renderoptions=type:directx
    endif
endif
set guioptions-=m                   " menu bar
set guioptions-=T                   " toolbar
set guioptions-=r                   " scrollbar right
set guioptions-=L                   " scrollbar left
set guioptions-=e                   " tab bar

let g:vim_monokai_tasty_italic = 1
if !exists('g:first_use')
    set background=light
    colorscheme breezy
endif

" MAPPINGS

let mapleader = " "

" follow tags, help, etc.
nnoremap <leader><CR> <C-]>

" center after search
nnoremap n nzz
nnoremap N Nzz

" use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
\ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>:pclose<CR>

" move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" compensate for German keyboard layout
nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" git
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Gvdiff<CR>

" completion:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" search
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <leader>l :History<CR>

" copilot
imap <silent> <C-l> <Plug>(copilot-dismiss)
imap <silent> <M-w> <Plug>(copilot-accept-word)
imap <silent> <M-l> <Plug>(copilot-accept-line)

" copilot chat
nnoremap <leader>c :CopilotChatOpen<CR>
vmap <leader>a <Plug>CopilotChatAddSelection

" LSP
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gi <Plug>(ale_go_to_implementation)
nmap <silent> <leader>s :ALESymbolSearch<space>
nmap <silent> K <Plug>(ale_hover)
nmap <silent> <leader>rn :ALERename<CR>
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)
nmap <silent> g. :ALECodeAction<CR>
nmap <silent> gI <Plug>(ale_import)
nmap <silent> gA :ALEFindReferences -quickfix<CR>:copen<CR>
nmap <silent> gh <Plug>(ale_detail)
nmap <silent> <leader>gq :ALEFix<CR>

" vim-test
let test#strategy = "vimterminal"
let test#vim#term_position = "belowright 12"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" show highlight
nmap <silent> <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>


" PLUGIN SETTINGS

" fzf
"run fzf in current window
let g:fzf_layout = { 'window': 'enew' }
" quit fzf with <esc>
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END
" use ripgrep if available
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
endif

" :Rg — fuzzy-filter on content only (--nth 4.. excludes filename from matching)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --glob "!*.cd" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" diagnostics currently need a fix in:
" ~/vimfiles/plugged/ale/autoload/ale/lsp_linter.vim line 573:
" if ale#lsp#HasCapability(l:id, 'pull_model') || a:linter.name is# 'ty'
" see https://github.com/dense-analysis/ale/issues/4971

call ale#linter#Define('python', {
\   'name': 'ty',
\   'lsp': 'stdio',
\   'executable': 'ty',
\   'command': 'ty server',
\   'project_root': function('ale#python#FindProjectRoot'),
\})

" ALE
let g:ale_linters = {
        \ 'python': ['ty', 'ruff'],
        \ 'haskell': ['hls'],
        \ 'json': ['jq'],
        \ 'cs': ['OmniSharp'],
        \}
let g:ale_fixers = {
        \ 'python': ['black', 'ruff'],
        \ 'haskell': ['fourmolu'],
        \ 'json': ['jq'],
        \}
let g:ale_fix_on_save=1
let ale_fix_on_save_ignore = ['jq']
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗'

let g:ale_python_auto_uv = 1
let g:ale_references_use_fzf = 0  " file preview helps, but it is not kept open
let g:ale_floating_preview = 0 " float. window is close to the cursor, but closes on next action

let g:ale_type_map = {
\ 'ty': {
\   'E': 'W',
\ },
\}


" asyncomplete
let g:asyncomplete_remove_duplicates = 1
augroup asyncomplete_sources
    autocmd!
    " filepath completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))
    " ALE
    autocmd User asyncomplete_setup call asyncomplete#register_source(
        \   asyncomplete#sources#ale#get_source_options({
        \       'priority': 10,
        \   }))
    " omni completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
        \ 'name': 'omni',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python', 'cs'],
        \ 'completor': function('asyncomplete#sources#omni#completor')
        \  }))
    " buffer completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python', 'cs'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
augroup END



" OmniSharp / C#
let g:OmniSharp_server_use_net6 = 1          " use net6+ build of OmniSharp-roslyn
let g:OmniSharp_selector_ui = 'fzf'          " use fzf for code-actions / find-symbol
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_popup = 0                    " use preview window (like ALE), stays open until <C-l>

let g:OmniSharp_server_path = 'C:\Users\NeuschmidF\bin\omnisharp-win-x64\OmniSharp.exe'
let g:OmniSharp_server_path = $HOME.'\bin\omnisharp-win-x64\OmniSharp.exe'

" Buffer-local C# bindings that mirror the global ALE LSP bindings so the
" same muscle-memory works in C# (via OmniSharp) and every other language
" (via ALE) without any conflict.
augroup omnisharp_commands
    autocmd!

    " --- mirror global LSP bindings ---
    autocmd FileType cs nmap <silent> <buffer> gd  <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> K   <Plug>(omnisharp_documentation)
    autocmd FileType cs nmap <silent> <buffer> <leader>rn  <Plug>(omnisharp_rename)
    autocmd FileType cs nmap <silent> <buffer> g.  <Plug>(omnisharp_code_actions)
    autocmd FileType cs xmap <silent> <buffer> g.  <Plug>(omnisharp_code_actions)
    autocmd FileType cs nmap <silent> <buffer> gI  <Plug>(omnisharp_fix_usings)
    autocmd FileType cs nmap <silent> <buffer> gA  <Plug>(omnisharp_find_usages)
    autocmd FileType cs nmap <silent> <buffer> gh  <Plug>(omnisharp_type_lookup)
    autocmd FileType cs nmap <silent> <buffer> <leader>gq  <Plug>(omnisharp_code_format)

    " --- OmniSharp extras ---
    autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)
    autocmd FileType cs nmap <silent> <buffer> <leader>s <Plug>(omnisharp_find_symbol)

    " navigate by method/property (mirrors ö/ä → [[ / ]] on German layout)
    autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)

    " auto type-lookup on cursor-hold
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " --- test running: override vim-test bindings with OmniSharp commands ---
    autocmd FileType cs nmap <silent> <buffer> <leader>tn :OmniSharpRunTest<CR>
    autocmd FileType cs nmap <silent> <buffer> <leader>tf :OmniSharpRunTestsInFile<CR>
    autocmd FileType cs nmap <silent> <buffer> <leader>td :OmniSharpDebugTest<CR>
augroup END


" Vimspector
" Run :VimspectorInstall netcoredbg  once to install the C# debug adapter.
let g:vimspector_enable_mappings = 'HUMAN'   " F5/F9/F10/F11/F12 standard bindings



if exists("$WIKI_ROOT") && !empty($WIKI_ROOT)
    let g:wiki_root = $WIKI_ROOT
else
    echohl WarningMsg
    echom "Warning: Environment variable WIKI_ROOT is not set."
    echohl None
endif

" LANGUAGE SPECIFIC SETTINGS

let python_highlight_all = 1

augroup languages
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype html setlocal sts=2 sw=2 expandtab
    autocmd FileType python setlocal colorcolumn=99
    autocmd FileType json setlocal sts=2 sw=2 expandtab foldmethod=syntax
    autocmd FileType typescript setlocal sts=2 sw=2
    autocmd FileType css setlocal sts=2 sw=2
augroup END

" STATUSLINE

function! ActiveStatus()
  let statusline=""
  let statusline.="%1*"
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
  let statusline.="%5*"
  let statusline.=""
  let statusline.="%2*"
  let statusline.="%{FugitiveStatusline()!=''?'\ \ '.FugitiveStatusline().'\ ':''}"
  let statusline.="%3*"
  let statusline.=""
  let statusline.="%4*"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="%3*"
  let statusline.="\ "
  let statusline.="%5*"
  let statusline.=""
  let statusline.="%1*"
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
  let statusline.="%{FugitiveStatusline()!=''?'\ \ '.FugitiveStatusline().'\ ':'\ '}"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="\ \ "
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

set laststatus=2
set statusline=%!ActiveStatus()
hi User1 guibg=#2d5c76 guifg=#cfcfc2
hi User5 guibg=#232629 guifg=#2d5c76
hi User2 guibg=#232629 guifg=#7a7c7d
hi User3 guibg=#31363b guifg=#232629
hi User4 guibg=#31363b guifg=#a5a6a8

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
