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
" Plug 'lervag/wiki.vim'
Plug 'sharat87/roast.vim' " http requests
Plug 'puremourning/vimspector'      " debugger (C# needs :VimspectorInstall netcoredbg)
Plug 'airblade/vim-gitgutter'

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

 " <C-l>: clear search highlight, update diffs, close preview and image popup
 nnoremap <silent> <C-l>
 \ :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>:pclose<CR>:if exists('g:image_popup')<Bar>call popup_close(g:image_popup)<Bar>unlet g:image_popup<Bar>endif<CR>

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
" nnoremap <silent> <leader>/ :Rg<CR>
" nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :History<CR>

command! ProjectFiles execute 'Files ' . FindProjectRoot()
command! ProjectRg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case --glob "!*.cd" -- ""', 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': FindProjectRoot()}), 0)

command! WikiRg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case --glob "!*.cd" -- ""', 1,
  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': fnamemodify($WIKI_ROOT, ':p')}), 0)

nnoremap <silent> <leader><leader> :ProjectFiles<CR>
nnoremap <silent> <leader>/ :ProjectRg<CR>
nnoremap <silent> <leader>w<leader> :execute 'Files ' . fnamemodify($WIKI_ROOT, ':p')<CR>
nnoremap <silent> <leader>w/ :WikiRg<CR>

nnoremap <leader>pr :echo FindProjectRoot()<CR>
nnoremap <silent> <leader>ww :edit $WIKI_ROOT<CR>
nnoremap <silent> <leader>w<leader>w :execute 'edit ' . $WIKI_ROOT . '/daily/' . strftime('%Y-%m-%d') . '.md'<CR>

nnoremap <silent> _ :edit .<CR>
nnoremap <leader>wn :e ~/OneDrive - Nordex SE/Wiki/


" copilot
imap <silent> <C-l> <Plug>(copilot-dismiss)
imap <silent> <M-w> <Plug>(copilot-accept-word)
imap <silent> <M-l> <Plug>(copilot-accept-line)

" copilot chat
nnoremap <leader>c :CopilotChatOpen<CR>
vmap <leader>a <Plug>CopilotChatAddSelection

" exit terminal mode
:tnoremap <Esc> <C-\><C-n>

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

" Tell ALE that 'htmlangular' should load linters/fixers defined for 'html'
let g:ale_linter_aliases = {'htmlangular': 'html'}

" ALE
let g:ale_linters = {
        \ 'python': ['ty', 'ruff'],
        \ 'haskell': ['hls'],
        \ 'json': ['jq'],
        \ 'cs': ['OmniSharp'],
        \ 'htmlangular' : ['angular'],
        \ 'html' : ['angular'],
        \ 'typescript': ['tsserver', 'eslint'],
        \}
let g:ale_fixers = {
        \ 'python': ['black', 'ruff'],
        \ 'haskell': ['fourmolu'],
        \ 'json': ['jq'],
        \ 'typescript': ['prettier'],
        \ 'htmlangular': ['prettier'],
        \ 'html' : ['prettier'],
        \ 'css': ['prettier'],
        \ 'scss': ['prettier'],
        \}
let g:ale_fix_on_save=1
let ale_fix_on_save_ignore = ['jq', 'prettier']
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '❗'

" Windows: ALE finds bash scripts in node_modules/.bin which can't execute.
" Use 'global' mode so ALE resolves via PATH (where .cmd wrappers live).
let g:ale_typescript_tsserver_use_global = 1
let g:ale_javascript_prettier_use_global = 1

" Prettier: tell it to use 'html' parser for Angular templates
autocmd FileType htmlangular let b:ale_javascript_prettier_options = '--parser html'

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


" LANGUAGE SPECIFIC SETTINGS

let python_highlight_all = 1

" Angular: detect component HTML templates as 'htmlangular' for ALE
augroup angular_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.component.html setlocal filetype=htmlangular
augroup END

" Windows: prepend project node_modules/.bin to PATH so .cmd wrappers are
" found when ALE uses 'global' executable lookup.
if has('win32')
    augroup node_path
        autocmd!
        autocmd DirChanged,VimEnter *
            \ if isdirectory(getcwd() . '\node_modules\.bin')
            \ | let $PATH = getcwd() . '\node_modules\.bin;' . $PATH
            \ | endif
    augroup END
endif

augroup languages
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd Filetype html,htmlangular setlocal sts=2 sw=2 expandtab
    autocmd FileType python setlocal colorcolumn=99
    autocmd FileType json setlocal sts=2 sw=2 expandtab foldmethod=syntax
    autocmd FileType typescript setlocal sts=2 sw=2
    autocmd FileType css,scss setlocal sts=2 sw=2
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

function! ShowRGBAImage(path, mode) abort
    if !filereadable(a:path)
        echohl ErrorMsg | echom 'File not found: ' . a:path | echohl None
        return
    endif

    let l:cell_w = get(g:, 'popup_image_cell_width',  8)
    let l:cell_h = get(g:, 'popup_image_cell_height', 16)

    if a:mode ==# 'big'
        let l:win_w = &columns
        let l:win_h = &lines
        let l:wr    = 1
        let l:wc    = 1
    else
        let [l:wr, l:wc] = win_screenpos(win_getid())
        let l:win_w = winwidth(0)
        let l:win_h = winheight(0) * 2 / 3
    endif

    let l:max_px_w = l:win_w * l:cell_w
    let l:max_px_h = l:win_h * l:cell_h

    let l:resized = tempname() .. '.png'
    let l:rgba    = tempname() .. '.rgba'

    call system('magick ' .. shellescape(a:path)
                \ .. ' -resize ' .. shellescape(l:max_px_w .. 'x' .. l:max_px_h .. '>')
                \ .. ' ' .. shellescape(l:resized))

    let l:dim = split(system('magick identify -format "%w %h" ' .. shellescape(l:resized)))
    if len(l:dim) != 2
        echohl ErrorMsg | echom 'Failed to get image size' | echohl None
        call delete(l:resized)
        return
    endif
    let l:w = str2nr(l:dim[0])
    let l:h = str2nr(l:dim[1])

    call system('magick ' .. shellescape(l:resized) .. ' -alpha on -depth 8 RGBA:' .. shellescape(l:rgba))
    call delete(l:resized)

    if !filereadable(l:rgba)
        echohl ErrorMsg | echom 'Conversion failed' | echohl None
        return
    endif

    let l:blob = readblob(l:rgba)
    call delete(l:rgba)

    if exists('g:image_popup')
        call popup_close(g:image_popup)
        unlet g:image_popup
    endif

    let g:image_popup = popup_create('', #{
                \ image:   #{ data: l:blob, width: l:w, height: l:h },
                \ line:    l:wr,
                \ col:     l:wc + l:win_w - 1,
                \ pos:     'topright',
                \ fixed:   v:true,
                \ border:  [0, 0, 0, 0],
                \ padding: [0, 0, 0, 0],
                \ })
endfunction

function! GetFileUnderCursor() abort
    if &filetype ==# 'netrw'
        let l:name = substitute(getline('.'), '^\s*', '', '')
        return b:netrw_curdir . '/' . l:name
    endif

    let l:line      = getline('.')
    let l:col       = col('.') - 1
    let l:candidate = ''

    for [l:o, l:c] in [['"', '"'], ["'", "'"], ['`', '`']]
        let l:pat = l:o . '\([^' . l:c . ']\+\)' . l:c
        let l:idx = 0
        while 1
            let l:ms = match(l:line, l:pat, l:idx)
            if l:ms < 0 | break | endif
            let l:me = matchend(l:line, l:pat, l:idx)
            if l:ms < l:col && l:col < l:me - 1
                let l:candidate = matchstr(l:line, l:pat)[1:-2]
                break
            endif
            let l:idx = l:me
        endwhile
        if !empty(l:candidate) | break | endif
    endfor

    if empty(l:candidate)
        let l:candidate = expand('<cfile>')
    endif

    " 1. Try as-is (absolute path or relative to :pwd)
    if filereadable(l:candidate)
        return l:candidate
    endif

    " 2. Try relative to the current file's directory
    let l:rel = expand('%:p:h') . '/' . l:candidate
    if filereadable(l:rel)
        return l:rel
    endif

    " Return original and let the caller report the error
    return l:candidate
endfunction

nnoremap <silent> <leader>i :call ShowRGBAImage(fnamemodify(GetFileUnderCursor(), ':p'), 'small')<CR>
nnoremap <silent> <leader>I :call ShowRGBAImage(fnamemodify(GetFileUnderCursor(), ':p'), 'big')<CR>


"C:\Users\NeuschmidF\Pictures\Screenshots\Screenshot_2026-02-03_161158.png
"C:\Users\NeuschmidF\Pictures\Screenshots\Screenshot 2026-02-24 155238.png"


" insert date
inoremap <C-g>d <C-g>u<C-R>=strftime("%Y-%m-%d")<CR>

" find project root
function! FindProjectRoot()
    let l:is_win = has('win32') || has('win64')
   " --- Get directory of current buffer ---
   if &filetype ==# 'netrw' && exists('b:netrw_curdir')
     let l:dir = b:netrw_curdir
   elseif isdirectory(expand('%:p'))
     let l:dir = expand('%:p')
   else
     let l:dir = expand('%:p:h')
   endif

    let l:dir_parts = filter(split(fnamemodify(l:dir, ':p'), '[/\\]'), '!empty(v:val)')
    if l:is_win
        call map(l:dir_parts, 'tolower(v:val)')
    endif

    " --- WIKI_ROOT ---
    if exists('$WIKI_ROOT') && !empty($WIKI_ROOT)
        let l:wiki_raw   = fnamemodify($WIKI_ROOT, ':p')
        let l:wiki_parts = filter(split(l:wiki_raw, '[/\\]'), '!empty(v:val)')
        if l:is_win
            call map(l:wiki_parts, 'tolower(v:val)')
        endif

        let l:n = len(l:wiki_parts)

        if l:n > 0 && len(l:dir_parts) >= l:n
                    \ && l:dir_parts[:l:n - 1] ==# l:wiki_parts
            return substitute(substitute(l:wiki_raw, '[/\\]\+$', '', ''), '\\', '/', 'g')
        endif
    endif

    " --- Git root ---
    let l:gitcmd = 'git -C ' . shellescape(l:dir) . ' rev-parse --show-toplevel'
    let l:git = systemlist(l:gitcmd)
    if v:shell_error == 0 && !empty(l:git)
        return substitute(l:git[0], '\\', '/', 'g')
    endif

    " --- Fallback: file's dir if outside cwd, otherwise cwd ---
    let l:cwd = fnamemodify(getcwd(), ':p')
    let l:cwd_parts = filter(split(l:cwd, '[/\\]'), '!empty(v:val)')
    if l:is_win | call map(l:cwd_parts, 'tolower(v:val)') | endif

    if len(l:dir_parts) >= len(l:cwd_parts)
                \ && l:dir_parts[:len(l:cwd_parts)-1] ==# l:cwd_parts
        " file is inside cwd — return cwd as usual
        return substitute(substitute(l:cwd, '[/\\]\+$', '', ''), '\\', '/', 'g')
    else
        " file is outside cwd — return the file's own directory
        return substitute(substitute(fnamemodify(l:dir, ':p'), '[/\\]\+$', '', ''), '\\', '/', 'g')
    endif
endfunction

function! s:PasteImageFromClipboard() abort
    let l:buf_dir = expand('%:p:h')
    if empty(l:buf_dir) | let l:buf_dir = getcwd() | endif

    let l:img_dir  = l:buf_dir . '\assets'
    let l:img_name = 'screenshot_' . strftime('%Y%m%d_%H%M%S') . '.png'
    let l:img_path = l:img_dir . '\' . l:img_name

    " Write a PS1 script to avoid shell-escaping nightmares
    let l:ps = tempname() . '.ps1'
    call writefile([
                \ 'Add-Type -AssemblyName System.Windows.Forms',
                \ 'if (-not [System.Windows.Forms.Clipboard]::ContainsImage()) { exit 1 }',
                \ 'New-Item -ItemType Directory -Force -Path "' . l:img_dir . '" | Out-Null',
                \ '[System.Windows.Forms.Clipboard]::GetImage().Save("' . l:img_path . '")',
                \ ], l:ps)
    call system('powershell -NoProfile -ExecutionPolicy Bypass -File ' . shellescape(l:ps))
    call delete(l:ps)

    if v:shell_error != 0
        echom 'No image in clipboard'
        return ''
    endif

    return '![](assets/' . l:img_name . ')'
endfunction

function! s:PasteImageNormal() abort
    let l:md = s:PasteImageFromClipboard()
    if empty(l:md) | return | endif
    call append(line('.'), l:md)
    normal! j
endfunction

augroup markdown_paste_image
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> <leader>p  :call <SID>PasteImageNormal()<CR>
    autocmd FileType markdown inoremap <buffer> <silent> <C-g>p     <C-R>=<SID>PasteImageFromClipboard()<CR>
augroup END

let g:netrw_hide=0
