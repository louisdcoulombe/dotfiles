" vim:fdm=marker

set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle Packages {{{
" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
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
Plugin 'https://github.com/vim-scripts/cmake.vim-syntax'
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
set history=1000

set nobackup
set nowritebackup

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

nnoremap <silent> <backspace> :nohlsearch<cr>
nnoremap <leader>erc :vsplit $MYVIMRC<CR>  
nnoremap <F12> :so %<CR>
noremap <Leader>m %
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
"noremap <Right> :vertical resize +5<CR>
"noremap <Left> :vertical resize -5<CR>
"noremap <Up> :resize +5<CR>
"noremap <Down> :resize -5<CR>
" }}}

" Ag {{{
ca Ag Ag!
nnoremap <leader>ff :Ag! <cword><CR>
" }}}

" Path related {{{
" }}}

" ------- Plugin configurations ------
" Vim Airline {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_z = '%{getcwd()}'
"}}}

" EasyMotion {{{
map <space> <Plug>(easymotion-s)
map t <Plug>(easymotion-t2)
let g:EasyMotion_smartcase = 1
"}}}

" Utilsnip {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<M-tab>"
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
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_folding = 0
let g:pymode_rope_completion = 0
" }}}

" CScope  {{{
nnoremap <leader>s :cs find s <cword><cr>
nnoremap <leader>c :cs find c <cword><cr>
nnoremap <leader>g :cs find g <cword><cr>
" }}}

