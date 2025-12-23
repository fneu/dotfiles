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
" completion / LSP
Plug 'dense-analysis/ale'                     " better configuration than LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

" test / debug
Plug 'puremourning/vimspector'
Plug 'vim-test/vim-test'

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

" VISUAL

" for vim 7
set t_Co=255

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" gvim font and ui
if has("gui_running")
    set guifont=Berkeley\ Mono:h12
    if has("win32")
        set renderoptions=type:directx
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
nnoremap <leader>t <C-]>

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
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gsh :Gpush<CR>
nnoremap <Leader>gll :Gpull<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>o :.Gbrowse<CR>

" completion:
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" search
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader><S-f> :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" copilot
imap <silent> <C-l> <Plug>(copilot-dismiss)
imap <silent> <M-w> <Plug>(copilot-accept-word)
imap <silent> <M-l> <Plug>(copilot-accept-line)

" copilot chat
nnoremap <leader>c :CopilotChatOpen<CR>
vmap <leader>a <Plug>CopilotChatAddSelection

" LSP
nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> K <Plug>(ale_hover)
nmap <silent> cd :ALERename<CR>
nmap <silent> <leader>rn :ALERename<CR>
nmap <silent> grn :ALERename<CR>
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)
nmap <silent> g. :ALECodeAction<CR>
nmap <silent> gI <Plug>(ale_import)
nmap <silent> gA <Plug>(ale_find_references)
nmap <silent> gh <Plug>(ale_detail)

" Vimspector debug
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

" vim-test
let test#strategy = "vimterminal"
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

let g:vimspector_install_gadgets = ['debugpy']
" let g:vimspector_configurations = {
"     \ 'python': {
"         \ 'adapter': 'debugpy',
"         \ 'configuration': {
"             \ 'request': 'launch',
"             \ 'type': 'python',
"             \ 'name': 'Launch file',
"             \ 'program': '${file}',
"             \ 'console': 'integratedTerminal',
"         \ },
"     \ },

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

" ALE
let g:ale_linters = {
        \ 'python': ['ruff', 'jedils'],
        \}
let g:ale_fixers = {
        \ 'python': ['ruff', 'black'],
        \}
let g:ale_fix_on_save=1
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗'

highlight ALEErrorSign guifg=#EF5350
highlight ALEWarningSign guifg=#FFEE58
highlight ALEError guibg=#3E2723
highlight ALEWarning guibg=#3E2723

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
        \ 'blacklist': ['python'],
        \ 'completor': function('asyncomplete#sources#omni#completor')
        \  }))
    " buffer completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
augroup END


" LANGUAGE SPECIFIC SETTINGS

let python_highlight_all = 1

augroup languages
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype html setlocal sts=2 sw=2 expandtab
    autocmd FileType python setlocal colorcolumn=79
    autocmd FileType json setlocal sts=2 sw=2 expandtab
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
