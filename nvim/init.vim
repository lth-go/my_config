call plug#begin('~/.local/share/nvim/plugged')

" =====插件=====
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 主题配色
Plug 'morhetz/gruvbox'
" 文件列表
Plug 'scrooloose/nerdtree'
" 状态栏
Plug 'vim-airline/vim-airline'
" 注释
Plug 'scrooloose/nerdcommenter'
" 括号匹配
Plug 'lth-go/auto-pairs'
" 彩虹括号
Plug 'luochen1990/rainbow', {'for': ['python', 'c', 'go']}
" 结对符修改
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
" 快速选中
Plug 'terryma/vim-expand-region'
" Tag跳转
Plug 'ludovicchabant/vim-gutentags'
" 高亮, 对齐
Plug 'sheerun/vim-polyglot'

call plug#end()

" =====文件=====

" 设置编码格式
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1

" 覆盖文件不备份
set nobackup
set nowritebackup
" 关闭交换文件
set noswapfile

set updatetime=300
set shortmess+=c

" =====命令行=====

" 菜单补全
set wildmode=longest:full,full
let &wildcharm = &wildchar
cnoremap <expr> / pumvisible() ? "\<Down>" : "/"

" 忽略文件
set wildignore+=*.swp,*.pyc,*.pyo,.idea,.git,*.o,tags


" =====状态栏=====

" 允许有未保存时切换缓冲区
set hidden

" =====行号=====

" 相对行号
set relativenumber number
" 行号切换
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number | set norelativenumber | endif
augroup END

" =====内容=====

" 禁止拆行
set nowrap
" 高亮显示当前行
set cursorline

" 禁止折叠
set nofoldenable

" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·

" 指定分割的区域
set splitbelow
set splitright

" 垂直滚动
set scrolloff=10
" 水平滚动
set sidescroll=1
set sidescrolloff=10

" =====搜索=====

" 搜索时大小写不敏感
set ignorecase
set smartcase

" =====缩进=====

" 智能缩进
set cindent
" 制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 连续空格视为制表符
set softtabstop=4
" 将Tab自动转化成空格
set expandtab
" 智能缩进
set shiftround

" yaml缩进
autocmd FileType javascript,json,yaml,sh set tabstop=2 shiftwidth=2 softtabstop=2

" Go
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" =====其他=====

" 使用系统剪切板
" need xsel
set clipboard=unnamedplus

" 输入法正常切换
autocmd InsertLeave * if system('fcitx-remote') != 0 | call system('fcitx-remote -c') | endif

" 自动添加头部
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh' | call setline(1, "\#!/bin/bash") | endif
    "如果文件类型为python
    if &filetype == 'python' | call setline(1, "\#!/usr/bin/env python") | call append(1, "\# encoding: utf-8") | endif
    normal G
    normal o
    normal o
endfunc

" 打开自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" =====快捷键=====

" 废弃快捷键
noremap <F1> <Nop>
inoremap <F1> <Nop>
noremap q <Nop>
noremap Q <Nop>
noremap K <Nop>

" 定义<Leader>
let mapleader=";"

noremap <Space> ;

" 快速保存及退出
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>

" 切换布局快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 用于绕行
noremap j gj
noremap k gk

" 替换行首行尾快捷键
noremap H ^
noremap L g_

" 命令行模式增强
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>

" 插入模式增强
inoremap <C-A> <Home>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-D> <Del>

" 搜索关键词居中
nnoremap n nzz
nnoremap N Nzz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz
nnoremap <silent> <C-]> <C-]>zz

nnoremap <silent><Backspace> :nohlsearch<CR>

" * 搜索不移动 可视模式高亮选中 -----
function! Starsearch_CWord()
    let wordStr = expand("<cword>")
    if strlen(wordStr) == 0 | return | endif
    if wordStr[0] =~ '\<'
        let @/ = '\<' . wordStr . '\>'
    else
        let @/ = wordStr
    endif
    let savedS = @s
    normal! "syiw
    let @s = savedS
    set hlsearch
endfunction

function! Starsearch_VWord()
    let savedS = @s
    normal! gv"sy
    let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
    let @s = savedS
    set hlsearch
endfunction

nnoremap <silent> * :set nohlsearch\|:call Starsearch_CWord()<CR>
vnoremap <silent> * :<C-u>set nohlsearch\|:call Starsearch_VWord()<CR>

" ----- start_search end -----

" 自动关闭buffer -----
function! s:SortTimeStamps(lhs, rhs)
    if a:lhs[1] > a:rhs[1] | return 1 | endif
    if a:lhs[1] < a:rhs[1] | return -1 | endif
    return a:lhs[0] > a:rhs[0]
endfunction

function! s:CloseBuffer(nb_to_keep)
  " 列出所有buffer, 过滤已修改的
  let saved_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && ! getbufvar(v:val, "&modified")')
  " 过滤当前已打开的buffer
  let window_buffers = map(range(1, winnr('$')), 'winbufnr(v:val)')
  let saved_buffers = filter(saved_buffers, 'index(window_buffers, v:val) == -1')
  " buffer按时间排序
  let buffer_to_time = map(copy(saved_buffers), '[(v:val), getftime(bufname(v:val))]')
  call filter(buffer_to_time, 'v:val[1] > 0')
  call sort(buffer_to_time, function('s:SortTimeStamps'))
  " 关闭buffer
  let buffers_to_strip = map(copy(buffer_to_time[:-a:nb_to_keep]), 'v:val[0]')
  if len(buffers_to_strip) > 0 | exe 'bd '.join(buffers_to_strip, ' ') | endif
endfunction

command! -nargs=1 CloseOldBuffers call s:CloseBuffer(<args>)

" 关闭当前buffer外的其他buffer
nnoremap <Leader>bd :CloseOldBuffers 1<CR>

augroup CloseOldBuffers
  au!
  au BufNew * call s:CloseBuffer(g:nb_buffers_to_keep)
augroup END

" 最大buffer数
let g:nb_buffers_to_keep = 6

" ----- auto_close_buffers end -----

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

" w!!用sudo保存
cabbrev w!! w !sudo tee > /dev/null %

" =====Coc=====

let g:coc_global_extensions = [
  \ 'coc-lists',
  \ 'coc-json',
  \ 'coc-xml',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-markdownlint',
  \ 'coc-python',
  \ 'coc-tsserver',
  \ 'coc-flow',
  \ 'coc-tabnine',
\ ]

nmap <silent> <leader>g <Plug>(coc-definition)zz
nmap <Leader>af  <Plug>(coc-format)
nmap <Leader>o :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
nmap <Leader>r <Plug>(coc-rename)

nmap <Leader>ff :CocList files<CR>
nnoremap <silent> <Leader>fc :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <Leader>fg :exe 'CocList -I grep'<CR>

vnoremap <leader>fc :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" =====NERDTree=====

" 显示隐藏文件
let NERDTreeShowHidden = 1
" 不显示冗余帮助信息
let NERDTreeMinimalUI = 1
" 退出vim时自动关闭
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略显示
let NERDTreeIgnore = [
  \ 'tags',
  \ '\.git$',
  \ '\.idea',
  \ '\.pyc',
  \ '\.pyo',
  \ '__pycache__',
  \ '\~$',
  \ '\.swp',
  \ '\.o',
  \ '\.so',
\ ]
" 打开文件树
nmap <C-\> :NERDTreeToggle<CR>

" =====Airline=====

" 设置airline主题
let g:airline_theme = 'gruvbox'
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
" 标签页只显示文件名
let g:airline#extensions#tabline#fnamemod = ':t'
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''
" 标签页快捷键
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <Leader>1 <Plug>AirlineSelectTab1
nmap <Leader>2 <Plug>AirlineSelectTab2
nmap <Leader>3 <Plug>AirlineSelectTab3
nmap <Leader>4 <Plug>AirlineSelectTab4
nmap <Leader>5 <Plug>AirlineSelectTab5
nmap <Leader>6 <Plug>AirlineSelectTab6
nmap <Leader>7 <Plug>AirlineSelectTab7
nmap <Leader>8 <Plug>AirlineSelectTab8
nmap <Leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '0': '0: ', '1': '1: ', '2': '2: ', '3': '3: ', '4': '4: ',
    \ '5': '5: ', '6': '6: ', '7': '7: ', '8': '8: ', '9': '9: '
\}

" =====Nerdcommenter=====

" 关闭默认快捷键
let g:NERDCreateDefaultMappings = 0
" 注释符左对齐
let g:NERDDefaultAlign = 'left'
" 注释有空格
let g:NERDSpaceDelims = 1
" 自动注释快捷键
map <C-_> <plug>NERDCommenterToggle

" =====RainbowParentheses=====

" 开启彩虹括号
let g:rainbow_active = 1

" =====vim-expand-region=====

" 选中区域配置, 1表示递归
let g:expand_region_text_objects = {
    \ 'iw'  :0,
    \ 'i"'  :0, 'a"'  :0,
    \ 'i''' :0, 'a''' :0,
    \ 'i`'  :0, 'a`'  :0,
    \ 'i]'  :1, 'a]'  :1,
    \ 'ib'  :1, 'ab'  :1,
    \ 'iB'  :1, 'aB'  :1,
    \ 'it'  :1, 'at'  :1,
\ }
" 快捷键
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" =====vim-gutentags=====

" ctags https://github.com/universal-ctags/ctags

" tags统一目录
let s:vim_tags = expand('~/.cache/ctags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 额外参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q', '--c-kinds=+px', '--languages=C,C++,Go,Python']

" =====vim-polyglot=====

" TODO: 高亮有问题
let g:polyglot_disabled = ['javascript']

" go

let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1

" javascript

let g:javascript_plugin_flow = 1

" =====主题=====

" 背景颜色
set background=dark

" 主题
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

highlight link Operator GruvboxRed

set termguicolors
