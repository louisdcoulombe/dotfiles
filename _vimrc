" vim:fdm=marker

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle Packages {{{
" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'xero/sourcerer.vim'
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
Plugin 'https://github.com/tpope/vim-surround'
Plugin 'https://github.com/tpope/vim-repeat'
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/airblade/vim-gitgutter'
Plugin 'https://github.com/godlygeek/tabular'
Plugin 'https://github.com/rking/ag.vim'
Plugin 'https://github.com/easymotion/vim-easymotion'
"Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'klen/python-mode'
Plugin 'https://github.com/davidhalter/jedi-vim'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'https://github.com/rhysd/vim-clang-format'
Plugin 'https://github.com/majutsushi/tagbar'
"Plugin 'https://github.com/Valloric/YouCompleteMe'
Plugin 'https://github.com/Shougo/vimproc.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"}}}

" Basic setup {{{
syntax on
set nocompatible
set autoread
set nu
set showmatch
set title
set textwidth=0
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set laststatus=2
set showcmd
set cursorline
set incsearch
set number
set noerrorbells         " don't beep
set noswapfile
set hidden

let g:pymode_rope = 0
nnoremap <F9> :set ignorecase!<cr>
nnoremap * :keepjumps normal! mi*`i<CR>
nnoremap <Backspace> :nohlsearch<cr>
nnoremap <F12> :so %<CR>
com! FormatJSON %!python -m json.tool
" Remap save
nnoremap <C-s> :w<cr>
" Sudo write
noremap <leader>W :w !sudo tee %<CR>
" }}}

" Windows navigation remapping. {{{
" CTRL-<H-L>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Buffer remap {{{
nnoremap <F6> :bn<cr>
nnoremap <F5> :bp<cr>
nnoremap <F7> :q<cr>
nnoremap <silent><F8> :bp\|bd #<cr>
"}}}

" Movements {{{
nnoremap j gj
nnoremap k gk
map f $
map F ^
map <C-e> :Vexplore<cr>

nnoremap ]] ]]zz
nnoremap [[ [[zz
" }}}

" Additionnal otion using leader {{{
let mapleader=","

nnoremap <leader>erc :vsplit $MYVIMRC<CR>  
noremap <Leader>m %
noremap <leader>o :PymodeLintAuto<cr>:w<cr>
" }}}

"Plugin configurations {{{
" Vim Airline {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_z = '%{getcwd()}'
"}}}

" EasyMotion {{{
nmap <space> <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t2)
let g:EasyMotion_smartcase = 1
"}}}

" Utilsnip {{{
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" }}}

" CTRL-P {{{
set wildignore+=*.swp,*.zip,*.exe,*.pbi,*.r34,*.pb*,*.d,\\Debug\\,\\Release\\,\\Obj\
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_clear_cache_on_exit = 0 " Do not clear filenames cache, to improve CtrlP startup
" }}}

" Python mode {{{
let g:pymode_rope = 1
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
let g:pymode_folding = 0
let g:pymode_rope_completion = 1

" }}}

" CScope  {{{
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" }}}

" Vim bookmarks {{{
let g:bookmark_sign = 'M'
" }}}

" Clang Formatter {{{

map <C-I> :pyf D:/Apps/LLVM/share/clang/clang-format.py<CR>
imap <C-I> <ESC>:pyf D:/Apps/LLVM/share/clang/clang-format.py<CR>i

" g:clang_format#
"let g:clang_format#style_options = {
"           \ "UseTab" : "Never",
"           \ "IndentWidth" : 4,
"           \ "BreakBeforeBraces" : "Allman",
"           \ "IndentCaseLabels": "false",
"           \ "ColumnLimit" : 0,
"           \ "AllowShortIfStatementsOnASingleLine" : "false"}
" }}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_left = 1
nmap <leader>b :TagbarToggle<cr>
"}}}

" YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = 'D:\Apps\Vim\.ycm_extra_conf.py'
" }}}
" }}}

" Colorscheme {{{
set t_Co=256
colorscheme sourcerer
" }}}

" Toggle Numbers  {{{
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <leader><tab> :call NumberToggle()<CR>
" }}}
            
" Disable arrow keys {{{
noremap <Right> :vertical resize +5<CR>
noremap <Left> :vertical resize -5<CR>
noremap <Up> :resize +5<CR>
noremap <Down> :resize -5<CR>
" }}}

" Ag {{{
ca Ag Ag!
nnoremap <leader>ff :Ag! <cword><CR>
" }}}

" Path related {{{
cd D:\Projects\
nnoremap <leader>lsr :cd d:\Projects\LSR_C\TopWorks-LMT-00.09.32\<cr>

nnoremap <leader>llt :call OpenLLT()<cr>
function OpenLLT()
    cd d:\Projects\LSR_C\LMT_SOURCES\LLT\
    cscope add cscope.out
endfunction

nnoremap <leader>vim :cd d:\Apps\Vim\vimfiles\<cr>

" }}}

" Ultisnip {{{
let g:UltiSnipsExpandTrigger="<tab>"

" }}}

" Windows related stuff  {{{

set guifont=Lucida_Console:h10

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
noremap <C-V> <C-V>
noremap <C-A> <C-A>
set ff=dos

set nobackup
set nowritebackup
" }}}

