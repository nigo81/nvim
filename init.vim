filetype plugin indent on
if has("termguicolors")
" fix bug for vim
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" enable true color
set termguicolors
endif
" 常用设置
" 设置行号
set number
set relativenumber
"突出显示当前行
"set cursorline
"自动挑选（不会超出显示）
set wrap 
set showcmd
"命令模式下按tab会提示
set wildmenu
" 按F2 进入粘贴模式
set pastetoggle=<F2>
" 高亮搜索
set hlsearch
set incsearch
"忽略大小写
set ignorecase
set smartcase
" 代码高亮
syntax on
"适配
set  nocompatible
"使用系统剪切板
set clipboard=unnamedplus

vnoremap Y "+y
" ===
" === 下次打开返回退出位置Restore Cursor Position
" ===
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"识别文件 
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
"可以用鼠标
set mouse=a
set encoding=utf-8
let &t_ut=''
"缩进
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"显示行尾空格
set list
set listchars=tab:>-,trail:-

set scrolloff=5
set tw=0
set indentexpr=
"行首按退格回到行尾
set backspace=indent,eol,start
" 设置折叠方式
set foldmethod=indent
set foldlevel=99
"不同模式下光标样式不同
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"状态栏
set laststatus=2
"当前文件目录下执行东西
set autochdir


" <leader>前缀键一些方便的映射
let mapleader=' '
let g:mapleader=' '
"set timeout timeoutlen=3000  按键启用时间
" 不用退出就重新加载vimrc
"map R :source $MYVIMRC<CR>
"分屏
map si :set splitright<CR>:vsplit<CR>
map sn :set nosplitright<CR>:vsplit<CR>
map su :set nosplitbelow<CR>:split<CR>
map se :set splitbelow<CR>:split<CR>
"改分屏大小 
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize +5<CR>
map <right> :vertical resize -5<CR>

"两下回车跳转到特定符号
map <leader><leader> <Esc>/<++><CR>:nohlsearch<CR>c4l
"调用figlet输出文字图形
map tx :r !figlet

" 使用 jk  进入 normal 模式
inoremap jk <Esc>`^
"搜索后取消高亮
noremap <leader><CR> :nohlsearch<CR>
" 切换 buffer
"nnoremap [b :bp<CR>
"nnoremap [n :bn<CR>
"nnoremap [k :bd<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>


" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"插入空行
"nmap <CR> o<Esc>k

"use <leader>e add pdb 
noremap <leader>e oimport pdb; pdb.set_trace()<Esc>
"Markdonw相关快捷键

autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
"autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
"autocmd Filetype markdown inoremap ,b ****<++><Esc>F*hi
"autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
"autocmd Filetype markdown inoremap ,i **<++><Esc>F*i
"autocmd Filetype markdown inoremap ,d ``<++><Esc>F`i
"autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
"autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
"autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
"autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
"autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
"autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
"autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
"autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
"autocmd Filetype markdown inoremap ,l --------<Enter>


" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null
" json 格式化
com! FormatJSONPy2Utf8 %!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), ensure_ascii=False, indent=2)"

"==========
" Compile function
"
map <F12> :call CreateTable()<CR>
func! CreateTable()
let line = getline('.')
let word_list = split(line,',')
let output = ["create table xxx ("]
let i =0
for word in word_list
    let i=i+1
    if i == len(word_list)
        call add(output,word . " varchar(255)")
    else
        call add(output,word . " varchar(255),")

    endif
endfor
call add(output,");")
let faild = append(0,output)
"return line
endfunc


map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!g++ % -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
exec "!g++ % -o %<"
exec "!time ./%<"
elseif &filetype == 'java'
exec "!javac %"
exec "!time java %<"
elseif &filetype == 'sh'
:!time bash %
elseif &filetype == 'python'
silent! exec "!clear"
exec "!time python3 %"
elseif &filetype == 'html'
exec "!chromium % &"
elseif &filetype == 'markdown'
exec "MarkdownPreview"
elseif &filetype == 'vimwiki'
exec "MarkdownPreview"
endif
endfunc

"map <C-R> :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
"exec "w"
"if &filetype == 'vim'
"exec "source $MYVIMRC"
"elseif &filetype == 'markdown'
"exec "echo"
"endif
"endfunc

function! ChineseCount() range
let save = @z
silent exec 'normal! gv"zy'
let text = @z
let @z = save
silent exec 'normal! gv'
let cc = 0
for char in split(text, '\zs')
if char2nr(char) >= 0x2000 
let cc += 1
endif
endfor
echo "Count of Chinese charasters is:"
echo cc
endfunc

vnoremap <F7> :call ChineseCount()<cr>

" tab 标签相关函数
" make tabline in terminal mode
function! Vim_NeatTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .=  (i+1) " 设置tab序号
        let s .= '%' . (i + 1) . 'T'
        " the label is made by MyTabLabel()
        let s .= ' %{Vim_NeatTabLabel(' . (i + 1) . ')} '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
    endif
    return s
endfunc
 
" get a single tab name 
function! Vim_NeatBuffer(bufnr, fullname)
    let l:name = bufname(a:bufnr)
    if getbufvar(a:bufnr, '&modifiable')
        if l:name == ''
            return '*'
        else
            if a:fullname 
                return fnamemodify(l:name, ':p')
            else
                return fnamemodify(l:name, ':t')
            endif
        endif
    else
        let l:buftype = getbufvar(a:bufnr, '&buftype')
        if l:buftype == 'quickfix'
            return '[Quickfix]'
        elseif l:name != ''
            if a:fullname 
                return '-'.fnamemodify(l:name, ':p')
            else
                return '-'.fnamemodify(l:name, ':t')
            endif
        else
        endif
        return '*'
    endif
endfunc
 
" get a single tab label
function! Vim_NeatTabLabel(n)
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:bufnr = l:buflist[l:winnr - 1]
    return Vim_NeatBuffer(l:bufnr, 0)
endfunc
 
" get a single tab label in gui
function! Vim_NeatGuiTabLabel()
    let l:num = v:lnum
    let l:buflist = tabpagebuflist(l:num)
    let l:winnr = tabpagewinnr(l:num)
    let l:bufnr = l:buflist[l:winnr - 1]
    return Vim_NeatBuffer(l:bufnr, 0)
endfunc
 
" setup new tabline, just like %M%t in macvim
set tabline=%!Vim_NeatTabLine()
set guitablabel=%{Vim_NeatGuiTabLabel()}


" Open Explore in new tab with current directory
function! Open_Explore(where)
    let l:path = expand("%:p:h")
    if l:path == ''
        let l:path = getcwd()
    endif
    if a:where == 0
        exec 'Explore '.fnameescape(l:path)
    elseif a:where == 1
        exec 'vnew'
        exec 'Explore '.fnameescape(l:path)
    else
        exec 'tabnew'
        exec 'Explore '.fnameescape(l:path)
    endif
endfunc


"===========中英文切换
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()


"==============
" 插件设置，这里使用了 vim-plug
call plug#begin('~/.vim/plugged')

" 安装插件只需要把 github 地址放到这里重启后执行 :PlugInstall 就好了
" 搜索
Plug 'mileszs/ack.vim'
Plug 'liuchengxu/vim-which-key' " 提示leaderkey
Plug 'voldikss/vim-floaterm' " 浮动窗口
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
"Plug 'mhartington/oceanic-next'
"Auto complete
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if !has('nvim')
Plug 'rhysd/vim-healthcheck'
endif

" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'kien/rainbow_parentheses.vim'
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}
"Plug 'davidhalter/jedi-vim'
"Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"html
Plug 'alvan/vim-closetag'
" General Highlighter
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

"注释
Plug 'preservim/nerdcommenter'
" Plug 'vim-python/python-syntax', { 'for' :['python', 'vim-plug'] }
" Markdown
Plug 'itchyny/calendar.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'
Plug 'ferrine/md-img-paste.vim'
"Plug 'michal-h21/vimwiki-sync'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'mzlogin/vim-markdown-toc'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/goyo.vim' " distraction free writing mode
Plug 'mbbill/undotree/'
Plug 'kshenoy/vim-signature'
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
"auto format python
Plug 'tell-k/vim-autopep8'
" Other useful utilities
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
call plug#end()
"设置成自定义的主题snazzy

let g:SnazzyTransparent = 1
color snazzy



"背景透明
hi Normal ctermfg=252 ctermbg=none

" 插件相关配置
" 禁止 startify 自动切换目录
let g:startify_change_to_dir = 0
noremap <leader>st :Startify<CR>

" nerdtree
nmap tv :NERDTreeFind<cr>
nmap tt :NERDTreeToggle<cr>

" ===
" === vimwiki
" ===

"let g:vimwiki_list = [{'path': '~/vimwiki/',
"                  \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_list = [{'path': '~/vimwiki/','ext': '.md'}]

let g:vim_markdown_math = 1
let g:vimwiki_global_ext = 0
autocmd FileType vimwiki set syntax=markdown

nmap <F21> <Plug>VimwikiNextLink " 将默认的<tab>来找下一个link替换成其它键
nmap <F22> <Plug>VimwikiPrevLink " 将默认的<tab>来找上一个link替换成其它键

" ===
" === MarkdownPreview
" ===
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
\ 'mkit': {},
\ 'katex': {},
\ 'uml': {},
\ 'maid': {},
\ 'disable_sync_scroll': 0,
\ 'sync_scroll_type': 'middle',
\ 'hide_yaml_meta': 1,
\ 'sequence_diagrams': {}
\ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


"===
"=== vim-table-mode
"===
"
map <leader>tm :TableModeToggle<CR>

" ===
" === vim-indent-guide
" ===
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig

" ===
" === Goyo
" ===
map <LEADER>gy :Goyo<CR>

" ===
" === autopep8
" ===
"map <LEADER>f :Autopep8<CR>:q<CR>
autocmd Filetype python noremap <LEADER>f :Autopep8<CR>:q<CR>

" ===
" === vim-signiture
" ===
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }
" ===
" === Undotree
" ===
let g:undotree_DiffAutoOpen = 0
map L :UndotreeToggle<CR>

" ===
" === ultisnips
" ===
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsUsePythonVersion=3

" ===
" === tagbar
" ===
map <silent> T :TagbarOpenAutoClose<CR>


" ===
" === coc.nvim
" ===
"    \ 'coc-pyright',
let g:coc_global_extensions = [
	\ 'coc-actions',
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-python',
    \ 'coc-pyright',
	\ 'coc-jedi',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-syntax',
	\ 'coc-translator',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-vetur',
	\ 'coc-yaml',
	\ 'coc-yank']
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <LEADER>h :call Show_documentation()<CR>

nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" coc-snippets
imap <C-k> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'nigo'


" ===
" === coc-snippets
" ===
" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" ===
" === rainbow_parentheses.vim
" ===
let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ===
" === easymotion
" ===
map ss <Plug>(easymotion-s2)

" ===
" === vim-markdown
" ===
set conceallevel=2
"let g:vim_markdown_conceal = 2
"
" ===
" === jedi-vim
" ===

"let g:jedi#use_splits_not_buffers = "left"
"let g:jedi#show_call_signatures = "0"
"let g:jedi#completions_enabled = 0
"autocmd FileType python setlocal completeopt-=preview


" ===
" === ctrlp
" ===
"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_switch_buffer = 'et'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ===
" === vimspectornoremap <silent><tab>m :tabnew<cr> 标签
set guitablabel=%N/\ %t\ %M
noremap <silent>tu :tabnew<cr>:Startify<cr>
noremap <silent>td :tabclose<cr>
noremap <silent><tab> :tabn<cr>
noremap <silent><s-tab> :tabp<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
inoremap <silent><s-tab> <ESC>:tabnext<CR>
set switchbuf=useopen,usetab,newtab

" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/vimspector/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/vimspector',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad

" === 
" ===nerdcommenter
" ===
let g:NERDDefaultAlign = 'start'

" ===
" === arc.vim
" ===
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" ===
" === which key
" ===
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
let g:which_key_disable_default_offset = 1
let g:which_key_use_floating_win = 0



call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_map.t = {
      \ 'name' : 'terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=6' , 'terminal'],
      \ 'f' : [':FloatermNew fzf'        , 'fzf'],
      \ 't' : [':FloatermToggle'        , 'toggle'],
      \ 'g' : [':FloatermNew lazygit'        , 'git'],
      \ 'r' : [':FloatermNew ranger'        , 'ranger'],
      \ }
" ===
" === floaterm
" ===
" Configuration example
"let g:floaterm_keymap_new    = '<leader>tt'
let g:floaterm_keymap_prev   = '<leader>tp'
let g:floaterm_keymap_next   = '<leader>tn'
let g:floaterm_keymap_toggle = '<leader>tt'

" ===
" === md-img-paste
" ===
let g:mdip_imgdir = 'pictures' 
let g:mdip_imgname = 'image'
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" ===
" === calendar
" ===
let g:calendar_frame = 'default'
let g:calendar_cache_directory = '~/vimwiki/calendar.vim'
nnoremap <silent> <leader>wc :Calendar<CR>
nnoremap <silent> <leader>wl :Calendar -view=clock<CR>
