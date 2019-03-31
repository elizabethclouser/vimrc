set nocompatible " be iMproved, required
filetype off " Required by Vundle

" -- Load Vundle plugins --"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'StanAngeloff/php.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'arnaud-lb/vim-php-namespace'

call vundle#end()            
filetype plugin indent on    

au BufRead *.blade.php set ft=blade.html.js.javascript
au BufNewFile *.blade.php set ft=blade.html.js.javascript

au BufRead *.php set ft=php.php-laravel
au BufNewFile *.php set ft=php.php-laravel

au BufRead *.vue set ft=js.javascript
au BufNewFile *.vue set ft=js.javascript

"---General---"
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set complete=.,w
set autowriteall
set autoindent 
set smartindent
set autoread
set number
set relativenumber
"set backspace=indent,eol,start 
set history=3  
set ruler	  
set incsearch 
set wildignore+=*/node_modules/*,*/vendor/*,*/.git/*,*/public/*,*/vagrant/*,*/bower_components/*,*/docs/*,*/libs/*,*/.idea/*,*/firebase_push/*,*/bootstrap/*,*/scripts/*

"---Theme---"
if $VIM_ENV == 'local'
    colorscheme one-dark
elseif $VIM_ENV == 'staging'
    colorscheme koehler
endif

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if has("autocmd")
  augroup vimrcEx
      au!
      " When editing a file, always jump to the last known cursor position.
      autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
  augroup END
endif 

"--- Automatically source ~/.vimrc on save. ---"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping. If unset (default), this may break plugins (but it's backward compatible).
  set langnoremap
endif

packadd matchit " Add html tags, if/else blocks, and more to the % command

"-- UltiSnips Setup --"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:snips_author = "Elizabeth Clouser <elizabeth@bonkstudios.com>"
let g:snips_package = "InsomniaCookies"
let g:snips_license = "https://insomniacookies.com "
let g:snips_link = "https://insomniacookies.com"
let g:snips_php_version = "7.1"

"-- Syntastic Setup --"
let g:syntastic_php_checkers = ['phpcs', 'phpmd']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = []

"-- Laravel Specific Key Mappings --"
nmap <Leader><Leader>v :e resources/views<cr>
nmap <Leader><Leader>a :e resources/assets<cr>
nmap <Leader><Leader>c :e app/Http/Controllers<cr>
nmap <Leader><Leader>r :e routes<cr>
nmap <Leader>l :e storage/logs/laravel.log<cr>

"Make it easy to edit the Vim config files"
nmap <Leader>ev :e $MYVIMRC<cr>

"-- VIM PHP Namespace Setup --"
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

let g:php_namespace_sort_after_insert = 1
set tags+=tags,tags.vendors

"-- Emmet Setup --"
let g:user_emmet_leader_key='<Leader>'

if $VIM_ENV == 'staging'
    "-- When you need to save a file and don't have ownership, but can sudo --"
    nmap <Leader>w :w !sudo tee %<cr>
endif
