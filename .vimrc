" Bootstrap vim-plug
" From
" <https://devel.tech/snippets/n/vIMmz8vZ/minimal-vim-configuration-with-vim-plug/#bootstrapping-vim-plug-automatically>

if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif

call plug#begin('~/.vim/plugged')

" Plugins
" git://github.com/nathanaelkane/vim-indent-guides.git
" https://github.com/Yggdroot/indentLine.git
" https://github.com/aklt/plantuml-syntax.git
" https://github.com/chiedojohn/vim-case-convert.git
" https://github.com/chrisbra/csv.vim
" https://github.com/junegunn/vim-easy-align.git
" https://github.com/nanotech/jellybeans.vim.git
" https://github.com/ntpeters/vim-better-whitespace.git
" https://github.com/rust-lang/rust.vim.git
" https://github.com/scrooloose/nerdcommenter.git
" https://github.com/scrooloose/nerdtree.git
" https://github.com/severin-lemaignan/vim-minimap.git
" https://github.com/vim-airline/vim-airline-themes.git
" https://github.com/vim-airline/vim-airline.git
" https://github.com/vim-syntastic/syntastic.git
"
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'aklt/plantuml-syntax'
Plug 'chiedojohn/vim-case-convert'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'

call plug#end()

" execute pathogen#infect()
"syntax on
"filetype plugin indent on

au BufRead,BufNewFile *.rs     set filetype=rust
au BufNewFile,BufRead *.gradle set filetype=groovy

" Numbering
set number relativenumber
set colorcolumn=81,101,111,121

" Line wrap
set wrap
set linebreak
set nolist "list disables linebreak

" NerdTree Ignore Patterns
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.class$', '\.aux$', '\.fls$', '\latexmk$']

":augroup numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
":augroup END

if ! &diff
   autocmd VimEnter * NERDTree
endif

"Theme
colorscheme jellybeans
set background=dark

" ----- airline status -----
set laststatus=2
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts=1

"Lightline
"set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

"Key bindings (shortcuts)
map <C-n> :NERDTreeToggle<CR>
let NERDTreeNodeDelimiter = "\t"

map <Leader>tn :set number! rnu!<CR>

" Markdown table formatting
au FileType markdown vmap <tab> :EasyAlign*<Bar><CR>
au FileType markdown map <Bar> vip :EasyAlign*<Bar><CR>


" Syntax Mappings
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

augroup filetypedetect
    au BufRead,BufNewFile *.mmd set filetype=markdown
    " associate *.mmd with md filetype
augroup END

" Don't mark URL-like things as spelling errors
syn match UrlNoSpell '\w\+:\/\/\S\+' contains=@NoSpell

" Indentation guides
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1

let mapleader="\\"

" Whitespace
map <Leader>s :StripWhitespace<CR>
map <Leader>su :syn match UrlNoSpell '\w\+:\/\/\S\+' contains=@NoSpell<CR>
map <Leader>ig :IndentLinesToggle<CR>

" Tabs
autocmd Filetype py setlocal tabstop=4
autocmd Filetype py setlocal softtabstop=4
autocmd Filetype py setlocal shiftwidth=4
autocmd Filetype py setlocal expandtab

set ts=4 sw=4 noet

set expandtab

" Tabs Markdwon
autocmd Filetype md setlocal tabstop=2
autocmd Filetype md setlocal softtabstop=2
autocmd Filetype md setlocal shiftwidth=2
autocmd Filetype md setlocal expandtab

filetype plugin on

" Markdown Line wrap
autocmd Filetype md setlocal wrap linebreak nolist



let g:indentLine_enabled = 0

" LaTeX tweaks (rendering slowdown)
au FileType tex setlocal nocursorline
au FileType tex :NoMatchParen
au FileType tex let g:indentLine_enabled = 0
au FileType md setlocal nocursorline
au FileType md :NoMatchParen

" close vim if only NERDTree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.txt setlocal spell


" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell! <cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

map <leader> t :TagbarToggle<CR>

" Nerd Commenter Plugin
let NERDSpaceDelims=1

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" " needed, and have indentation at 8 chars to be sure that all indents are
" tabs
" " (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = "-std=c++17 -Wall -Wextra -Wpedantic -Weffc++"

" Fix for Ubuntu PPA install of 3.7
let g:syntastic_python_checkers = ['python', "pylint", "pycodestyle"]

" Apply Java Syntastic fix based on <https://stackoverflow.com/a/39563219>
"let g:syntastic_java_javac_config_file_enabled = 1

" Disable Syntastic for Java files
let g:syntastic_java_checkers = []


" Convert Files to txt/markdown in a new buffer
augroup filter_special_file
    au!
    au BufWinEnter  *.{doc,docx,epub,odp,odt,pdf,rtf}  call s:filter_special_file()
augroup END

fu! s:filter_special_file() abort
    if get(b:, 'did_filter_special_file', 0)
        return
    endif

    let fname = shellescape(expand('%:p'), 1)
    let ext = expand('%:e')
    let ext2cmd = {
    \               'doc' : '%!antiword '.fname,
    \               'docx': '%!pandoc -f docx -t markdown_mmd --atx-headers --columns=80 '.fname,
    \               'epub': '%!pandoc -f epub -t markdown '.fname,
    \               'odp' : '%!odt2txt '.fname,
    \               'odt' : '%!odt2txt '.fname,
    \               'pdf' : '%!pdftotext -nopgbrk -layout -q -eol unix '.fname.' -',
    \               'rtf' : '%!unrtf --text',
    \             }

    if has_key(ext2cmd, ext)
        let filter = matchstr(ext2cmd[ext], '%!\zs\S*')
        if !executable(filter)
            echom 'cannot filter '.expand('%:p').'; please install '.filter
            return
        endif

        setl ma noro
        sil exe ext2cmd[ext]
        let b:did_filter_special_file = 1
        setl noma ro nomod
    endif
endfu


" air-line
let g:airline_powerline_fonts = 1

" Force UTF 8  encoding for poweline symbols
" scriptencoding utf-8
" set encoding=utf-8
