" vim configuration by Fabian Neuschmidt

filetype plugin indent on
syntax enable

" detect operating system:
" https://vi.stackexchange.com/questions/2572/detect-os-in-vimscript
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
        let g:dotvim = expand("~/vimfiles")
    elseif has("win32unix")
        let g:os = "Cygwin"
        let g:dotvim = expand("~/.vim")
    else
        let g:os = substitute(system('uname'), '\n', '', '')
        let g:dotvim = expand("~/.vim")
    endif
endif

" remove gui clutter
if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set belloff=all    "disable bell
    if g:os == "Windows"
        set guifont=Fira\ Code:h10
    endif
endif

" install vim-plug on any os
if g:os == 'Windows'
    if empty(glob(g:dotvim . '/autoload/plug.vim'))
        silent execute 'iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni ' . g:dotvim . '/autoload/plug.vim -Force'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    if empty(glob(g:dotvim . '/autoload/plug.vim'))
        silent execute '!curl -fLo ' . g:dotvim . '/autoload/plug.vim --create-dirs '
            \ . '"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Fira Code ligature fix
if g:os == 'Windows'
    if has("gui_running")
        set renderoptions=type:directx
        set encoding=utf-8
    endif
endif

" PLUGINS

call plug#begin()

" colorscheme
Plug 'sjl/badwolf'

" tools / editing
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " fzf integration for vim
Plug 'tpope/vim-fugitive'           " git integration
Plug 'tpope/vim-commentary'         " comment stuff out with gcc / gc<motion>
Plug 'tpope/vim-surround'           " cs, ds, ys(s), v_S surroundings
Plug 'tpope/vim-repeat'             " make repeat and surround repeatable
Plug 'tpope/vim-vinegar'            " netrw improvements
Plug 'tpope/vim-unimpaired'         " various ]/[ bindings
Plug 'tpope/vim-eunuch'             " :SudoWrite, :Unlink, :Rename, ...
Plug 'wincent/terminus'             " FocusGained and cursor shape in Konsole
Plug 'mattn/emmet-vim'              " html magic with <C-y>
Plug 'ap/vim-css-color'             " highlight colors in various file types

" languages
Plug 'hynek/vim-python-pep8-indent' " PEP8 conform indenting
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'HerringtonDarkholme/yats.vim' " TypeScript Syntax
Plug 'othree/html5.vim'             " Html5 Syntax
Plug 'othree/yajs.vim'              " JavaScript Syntax

" completion / LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'SirVer/ultisnips'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-ultisnips'

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

set shortmess+=c                    " suppress ins-complete-menu messages
set noshowmode                      " suppress mode messages -> use for echodoc
set wildmenu                        " command line completion
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set ruler                           " show current position in statusline

set scrolloff=3                     " always show n lines above/below cursor
set sidescrolloff=5
set display+=lastline               " show part of long last line (and marker)

set encoding=utf-8
set showbreak=?\ "
set listchars=tab:?\ ,nbsp:?,trail:·,extends:,precedes:
set list                            " highlight above chars respectively
set formatoptions+=j                " delete comment char when joining lines

set autoread                        " auto load file changes, needs terminus

set history=1000                    " command-line history
set nobackup
set noswapfile

set modeline

if !isdirectory(g:dotvim . "/undo-dir")
    call mkdir(g:dotvim . "/undo-dir", "", 0700)
endif
execute 'set undodir='. g:dotvim . '/undo-dir'
set undofile                        " keep undo history (forever)

set mouse=a                         " use mouse in all modes
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus " use system clipboard
endif

" VISUAL

colorscheme badwolf

hi User1 ctermbg=39 ctermfg=16 cterm=NONE guibg=#0a9dff guifg=#000000 gui=NONE
hi User2 ctermbg=241 ctermfg=15 cterm=NONE guibg=#666462 guifg=#ffffff gui=NONE
hi User3 ctermbg=238 ctermfg=241 cterm=NONE guibg=#45413b guifg=#666462 gui=NONE
hi User4 ctermbg=238 ctermfg=15 cterm=NONE guibg=#45413b guifg=#ffffff gui=NONE
hi User5 ctermbg=241 ctermfg=39 cterm=NONE guibg=#666462 guifg=#0a9dff gui=NONE
hi StatusLineNC ctermbg=238 ctermfg=245 cterm=NONE guibg=#45413b guifg=#998f84 gui=NONE

" MAPPINGS

let mapleader = " "

" follow tags, help, etc.
nnoremap <leader>t <C-]>

" goto Definition
nnoremap <leader>d :LspDefinition<CR>
nnoremap <silent> ]c :LspNextDiagnostic<CR>
nnoremap <silent> [c :LspPreviousDiagnostic<CR>

" center after search
nnoremap n nzz
nnoremap N Nzz

" use <C-l> to clear the highlighting of :hlsearch
nnoremap <silent> <C-l>
\ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

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
nnoremap <Leader>gsh :Gpush<CR>
nnoremap <Leader>gll :Gpull<CR>
nnoremap <Leader>gg :Git<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>go :Gbrowse<CR>

" completion:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" search
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

if g:os == 'Linux'
    if executable('rg')
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
        nnoremap <silent> <leader><S-f> :Find<CR>
    endif
endif

" PLUGIN SETTINGS

" fzf
"run fzf in current window -> DISABLED BECAUSE IT BREAKS ARROW KEYS
augroup fzf
    autocmd!
    autocmd FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
augroup END
" ignore some potentially large folders
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" use ripgrep if available
if g:os == 'Linux'
    if executable('rg')
      let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
      set grepprg=rg\ --vimgrep
    endif
endif

" asyncomplete
let g:asyncomplete_remove_duplicates = 1
augroup asyncomplete
    autocmd!
    " filepath completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))
    " buffer completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
    " omni completion
    autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
        \ 'name': 'omni',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['python', 'tex'],
        \ 'completor': function('asyncomplete#sources#omni#completor')
        \  }))
augroup END

" vim-lsp
let g:lsp_signs_enabled=1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 1

" echodoc
let g:echodoc_enable_at_startup = 1

" LANGUAGE SPECIFIC SETTINGS

let python_highlight_all = 1

augroup languages
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype html setlocal sts=2 sw=2 expandtab
    autocmd Filetype yaml setlocal sts=2 sw=2 expandtab
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
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
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
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ '}"
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

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END

" Work around a bug in vim where it uses a 'background color erase'
" funcitonality that alacritty doesn't support.
let &t_ut=''

