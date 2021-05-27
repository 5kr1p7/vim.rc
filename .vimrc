if !1 | finish | endif

augroup vimrc
    autocmd!
augroup END

let using_neovim = has('nvim')
let using_vim = !using_neovim
let fancy_symbols_enabled = 1


let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


call plug#begin('~/nvim/plugged')
Plug 'tpope/vim-fugitive'
call plug#end()

call plug#begin()
  Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'phpactor/ncm2-phpactor'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'preservim/nerdtree' |  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' | Plug 'ryanoasis/vim-devicons'
  Plug 'itchyny/lightline.vim'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  Plug 'stephpy/vim-php-cs-fixer', {'for': 'php'}
  Plug 'nishigori/vim-php-dictionary', {'for': 'php'}
  Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'} " php refactoring options
  Plug '2072/php-indenting-for-vim', {'for': 'php'}
  Plug 'tobyS/vmustache' | Plug 'tobyS/pdv', {'for': 'php'} " php doc autocompletion 
  
  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-scripts/IndexedSearch'
  
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'roxma/vim-hug-neovim-rpc'
  
  if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
  else
    Plug 'Shougo/deoplete.nvim'
  endif
  
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'Shougo/context_filetype.vim'
  Plug 'davidhalter/jedi-vim'
  Plug 'Townk/vim-autoclose'
  Plug 'tpope/vim-surround'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'sheerun/vim-polyglot'
  Plug 'mileszs/ack.vim'
  Plug 'lilydjwg/colorizer'
  Plug 'fisadev/vim-isort'
  Plug 'valloric/MatchTagAlways'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'
  
  Plug 'neomake/neomake'
  
  Plug 'chrisbra/csv.vim'
  
  Plug 'honza/vim-snippets' " snippets
  Plug 'AndrewRadev/splitjoin.vim' " Split arrays in PHP / struct in Go / other things
  
  Plug 'majutsushi/tagbar'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'patstockwell/vim-monokai-tasty'
  
  Plug 'elzr/vim-json'
  Plug 'styled-components/vim-styled-components'
  Plug 'pangloss/vim-javascript'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'jparise/vim-graphql'
call plug#end()

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

"let g:lightline = {
"      \ 'colorscheme': 'wombat',
"      \ }

let g:lightline = {
      \ 'colorscheme': 'monokai_tasty',
      \ }

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif      

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

map <C-n> :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

let g:NERDTreeDisableFileExtensionHighlight = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

" If you have vim-devicons you can customize your icons for each file type.
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight

let g:NERDTreeLimitedSyntax = 1

let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let NERDTreeHighlightCursorline = 0

" set g:NERDTreeExtensionHighlightColor if you want a custom color instead of the default one
let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to .hbs and .lhs files with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['dropbox', 'node_modules', 'favicon.ico'] " enable highlight for dropbox and node_modules folders, and favicon.ico files with default colors

let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'cpp', 'php', 'rb', 'js', 'css', 'html'] " enabled extensions with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['node_modules', 'favicon.ico'] " enabled exact matches with default colors

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25



" colorscheme hypnos
set noswapfile
set number

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set shiftround

set ignorecase
set smartcase

autocmd vimrc BufWrite *.php,*.js,*.jsx,*.vue,*.twig,*.html,*.sh,*.yaml,*.yml,*.clj,*.cljs,*.cljc call general#DeleteTrailingWS()

nmap <F6> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

if !has('nvim') " Vim 8 only
    pythonx import pynvim
endif

set encoding=utf-8
let g:airline_section_x = ''

" set list
set list listchars=tab:\┆\ ,trail:·,nbsp:±

" doesn't prompt a warning when opening a file and the current file was modified but not saved
set hidden

augroup nerdtree
  autocmd!
  autocmd FileType nerdtree syntax clear NERDTreeFlags
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END

"Tagbar######################################################
"Set the distribution of the two here
let g:tagbar_vertical = 25
"Remove the first line of help information
let g:tagbar_compact = 1
"When editing the code, inTagbarAutomatically track variables
let g:tagbar_autoshowtag = 1
"Personal hobbies, expand and close the folder icon
let g:tagbar_iconchars = ['▸', '▾']
"<F3>as toggle
nmap <F3> :TagbarToggle<CR>
"Automatically open when opening vim
"autocmd VimEnter * nested :TagbarOpen
wincmd l
"If you don’t add this sentence, the current cursor will be atNerdtreearea
autocmd VimEnter * wincmd l

map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1

map <F2> :w! <CR>
map <F10> :q <CR>

let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"

augroup filetype_nerdtree
    au!
    au FileType nerdtree call s:disable_lightline_on_nerdtree()
    au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
augroup END

fu s:disable_lightline_on_nerdtree() abort
    let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
    call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
endfu

let g:deoplete#enable_at_startup = 1
let g:python3_host_prog  = '/usr/bin/python3'

if !has('nvim') " Vim 8 only
    pythonx import pynvim
endif

filetype plugin on
filetype indent on
set ls=2
set incsearch
set hlsearch

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set nu
set fillchars+=vert:\ 

set completeopt+=noinsert

set scrolloff=3

nnoremap <silent> // :noh<CR>
set shell=/bin/bash 

let g:tagbar_autofocus = 1
set wildmode=list:longest

" tab navigation mappings
map tt :tabnew 
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" Run linter on write
" autocmd! BufWritePost * Neomake

nmap ,t :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

highlight! link NERDTreeFlags NERDTreeDir

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif

    let g:vim_monokai_tasty_italic = 1
    colorscheme vim-monokai-tasty
    let g:airline_theme='monokai_tasty'
    let g:lightline = { 'colorscheme': 'monokai_tasty' }  " lightline theme
else
    colorscheme delek
endif

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>



" Deoplete -----------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack 
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!

if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif
