" ========== Vundle==========

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 语法检查
Plugin 'scrooloose/syntastic'
" 代码补全
Plugin 'Valloric/YouCompleteMe'
" 文件查找
Plugin 'ctrlpvim/ctrlp.vim'
" 主题配色
Plugin 'tomasr/molokai'
" 文件列表
Plugin 'scrooloose/nerdtree'
" 状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" 注释
Plugin 'scrooloose/nerdcommenter'
" 括号匹配
Plugin 'jiangmiao/auto-pairs'
" 彩虹括号
Plugin 'kien/rainbow_parentheses.vim'
" 代码格式化
Plugin 'Chiel92/vim-autoformat'
" 历史回退
Plugin 'sjl/gundo.vim'
" 标签修改
Plugin 'tpope/vim-surround'
" 快速移动
Plugin 'easymotion/vim-easymotion'
" html标签匹配
Plugin 'valloric/MatchTagAlways'
" 自动补全html/xml标签
Plugin 'docunext/closetag.vim'

call vundle#end()
filetype plugin indent on


" ==========基础设置==========

" 文件检测类型
filetype on
" 根据类型加载对应插件
filetype plugin on
" 智能缩进
filetype indent on

" 设置编码格式
set encoding=utf-8

" 文件修改自动载入
set autoread
" 自动保存
set autowrite
" 取消备份
set nobackup
" 关闭交换文件
set noswapfile

" 正则magic模式
set magic

" 快捷键延迟
set ttimeoutlen=10

" history存储容量
set history=2000

" 忽略文件
set wildignore+=*.swp,*.pyc,.idea,.git


" ==========界面==========

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 显示当前正在输入的命令
set showcmd

" 菜单补全
set completeopt=longest,menu
" 补全内容只显示补全列表
set completeopt-=preview
" vim 自身命令行模式智能补全
set wildmenu

" 相对行号
set relativenumber number
autocmd FocusLost * :set norelativenumber number
autocmd FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" 禁止拆行
set nowrap
" 高亮显示当前行/列
set cursorline
"set cursorcolumn


" ==========内容==========

" 开启语法高亮功能
syntax enable
" 允许替换默认配色
syntax on

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" 括号匹配时间
set matchtime=2

" 高亮显示搜索结果
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase

" 退格键正常处理
set backspace=2

" 智能缩进
set smartindent
" 自动缩进
set autoindent

" 制表符占用空格数
set tabstop=4
" 自动缩进距离
set shiftwidth=4
" 连续空格视为制表符
set softtabstop=4
" 按退格键一次删掉4个空格
set smarttab
" 将Tab自动转化成空格
set expandtab
" 智能缩进
set shiftround

" 显示tab跟空格
set list
set listchars=tab:>-,trail:·,nbsp:·

" 光标下方保留的行数
set scrolloff=5


" ==========其他==========
"
" 输入法正常切换
autocmd InsertLeave * if system('fcitx-remote') != 0 | call system('fcitx-remote -c') | endif

" 自动添加python文件头部
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" 打开自动定位到最后编辑的位置
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ==========快捷键==========

" 废弃F1
noremap <F1> <Esc>"

" 定义快捷键前缀，即<Leader>
let mapleader=";"

" 切换布局快捷键
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 替换行首行尾快捷键
noremap H ^
noremap L $

" 切换buffer
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" 命令行模式增强
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" ==========插件==========

" ==========Syntastic==========

" 打开时语法检查
let g:syntastic_check_on_open = 1
" 设置python语法检查
let g:syntastic_python_checkers=['pyflakes']
" 右下角状态栏隐藏
let g:syntastic_stl_format = ""
" 显示错误列表
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5


" ==========YCM==========

" 下拉栏快捷键
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<c-k>']
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<c-j>']
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 允许vim 加载.ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 关闭语法检查
let g:ycm_show_diagnostics_ui = 0
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 指定jedi的Python解释器路径，防止虚拟环境问题
let g:ycm_server_python_interpreter = 'python'
" 函数跳转
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>


" ==========NERDTree==========

" 使用 NERDTree 插件查看工程文件
nmap <Leader>d :NERDTreeToggle<CR>
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" 退出vim时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.git$','\.idea']


" ==========Autoformat==========

" 需安装python-autopep8
" 格式化代码快捷键
noremap <F3> :Autoformat<CR>


" ==========Airline==========

" 设置airline主题
let g:airline_theme="monochrome"
" 打开tabline功能
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
" 去除右上角buffer
let g:airline#extensions#tabline#buffers_label = ''
" 分隔符
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = '|'


" ==========RainbowParentheses==========

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 8
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" ==========CtrlP==========

" 搜索快捷键修改
let g:ctrlp_map = '<leader>f'
" 忽略文件
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|idea)$',
  \ 'file': '\v\.(so|zip|tar|tar.gz|pyc)$',
  \ }

let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" ==========gundo==========

" gundo打开快捷键
nnoremap <Leader>ud :GundoToggle<CR>


" ==========MatchTagAlways==========

" html标签跳转
nnoremap <leader>% :MtaJumpToOtherTag<CR>


" ==========easymotion==========

" 忽略大小写
let g:EasyMotion_smartcase = 1


" ==========主题设置==========

" 设置背景颜色
set background=dark
" molokai主题
let g:rehash256 = 1
colorscheme molokai
