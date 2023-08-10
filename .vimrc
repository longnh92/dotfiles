"========================================================
" INSTALL PLUGINS
"
"========================================================
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

filetype off
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/tComment'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-rails'
Plug 'kchmck/vim-coffee-script'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'matze/vim-move'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'pgdouyon/vim-yin-yang'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()
syntax on
filetype on
filetype indent on
filetype plugin on
set mouse=a
set hlsearch
set ai
set ruler
set linespace=1
set gfn=DejaVu\ Sans\ Mono\ for\ Powerline:h13
let g:auto_ctags = 1
set wrap linebreak nolist
set breakindent
set nofoldenable
set tags=./tags;,tags;
set ruler
set number
set expandtab
set autoindent
set clipboard=unnamed
set splitright
set splitbelow
set ttyfast
set lazyredraw
set laststatus=2
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set background=dark
set relativenumber
set bs=2 tabstop=2 shiftwidth=2 softtabstop=2
" colorscheme yin
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'light'

" Fix iterm display
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"=======================================================
" CONFIG LIGHTLINE
"======================================================
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = {
      \     'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ], ['lineinfo', 'percent']],
      \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }

"========================================================
" CONFIG ALE
"========================================================
let g:ale_linters = {
      \'javascript': ['eslint'],
      \'ruby': ['rubocop']
      \}
let g:ale_fixers = {
      \'javascript': ['eslint'],
      \'ruby': ['rubocop']
      \}
let g:ale_lint_on_text_changed="never"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_set_quickfix = 1
map <silent> <leader>ln :ALENext<CR>
map <silent> <leader>lp :ALEPrevious<CR>
map <silent> <leader>lf :ALEFix<CR>

"========================================================
" CONFIG AUTO PAIR
"========================================================
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'
let g:AutoPairsMultilineClose = 0
let g:indentLine_enabled = 0
"========================================================
" CONFIG MISC
"========================================================
" Tmux navigation
let g:tmux_navigator_no_mappings = 1
" Rpsec config
let test#strategy = "neovim"
" Solve vim ESC delay
set timeoutlen=1000 ttimeoutlen=0
if has("autocmd")
"   autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"   autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"   autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"   autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"   autocmd FileType go set tabstop=8 shiftwidth=8 softtabstop=8
"   autocmd FileType xml set equalprg=xmllint\ --format\ -
"   " autocmd VimEnter * call AirlineInit()
"   " autocmd VimEnter * AirlineTheme bubblegum
"   autocmd BufWritePre * StripWhitespace
"   autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"   autocmd FileType markdown set textwidth=80
"   autocmd FileType markdown set formatoptions-=t
"   autocmd Filetype cpp setlocal ts=4 sw=4 sts=0 expandtab
  autocmd BufNewFile,BufRead *.slim set syntax=haml
endif
let g:webdevicons_enable_ctrlp = 1
let g:move_key_modifier = 'C'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.eex,*.html.erb"
let g:jsx_ext_required = 0
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'
"========================================================
" FUNCTIONS
"========================================================
" Update ruby ctags
function! UpdateFullRubyTags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
endfunction

function! UpdateRubyTags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log .')
endfunction

" Toogle indents
function! IndentGuideToggle()
  let g:indent_guide_displayed = get(g:, 'indent_guide_displayed', '0')
  if g:indent_guide_displayed=='0'
    let g:indent_guide_displayed = '1'
    execute 'IndentLinesEnable'
    set colorcolumn=+1
  else
    let g:indent_guide_displayed = '0'
    execute 'IndentLinesDisable'
    set colorcolumn=0
  endif
endfunction
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
"========================================================
" MAPPING COC
" =======================================================
let g:coc_global_extensions = ['coc-solargraph']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"========================================================
" MAPPING FZF
"========================================================
map <leader>f <ESC>:Files<CR>
map <leader>h <ESC>:History<CR>
map <Leader>b <ESC>:Buffers<CR>
map <silent> <leader>/ <ESC>:BLines<CR>
map <leader>ag <ESC>:Ag<space>
map <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"))<cr>
map <silent> <leader>mm <ESC>:Commands<CR>
"========================================================
" MAPPING NERDTree
"========================================================
map <silent> <leader>ls <ESC>:NERDTreeToggle<CR>
map <silent> <leader>rev :NERDTreeFind<CR>
let NERDTreeMapOpenSplit = 'x'
let NERDTreeMapOpenVSplit = 'v'
"========================================================
" MAPPING RSPEC
"========================================================
map <Leader>tt :TestFile<CR>
map <Leader>ts :TestNearest<CR>
map <Leader>tl :TestLast<CR>
map <Leader>ta :TestSuite<CR>
let test#ruby#rspec#executable = 'bundle exec rspec'

" Cusstom search command
map / :?
omap / :?
"========================================================
" MAPPING EASYALIGN
"========================================================
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"========================================================
" MAPPING GIT
"========================================================
map <silent> gb :Gblame<CR>
map <silent> ghub :Gbrowse<CR>
"========================================================
" MAPPING MISC
"========================================================
map <leader>urt <ESC>:call UpdateRubyTags()<CR>
map <leader>ufrt <ESC>:call UpdateFullRubyTags()<CR>
map <leader>uet <ESC>:call UpdateElixirTags()<CR>
nnoremap <silent> <Leader><CR> <ESC>:noh<CR>
map <silent> <leader>i <ESC>:call IndentGuideToggle()<CR>
map <silent> <leader>' cs'"
map <silent> <leader>" cs"'
map <silent> <leader><leader> <C-^><CR>
map <silent> <leader>u :UndotreeToggle<CR>
map <silent> <space>h <C-W><C-H>
map <silent> <space>j <C-W><C-J>
map <silent> <space>k <C-W><C-K>
map <silent> <space>l <C-W><C-L>
map <silent> <leader>wq <C-W>q
map <silent> <leader>path :let @+=@%<CR>
nnoremap <leader>s :w<cr>
inoremap <leader>s <C-c>:w<cr>
if has("nvim")
  tnoremap <c-e> <C-\><C-n>
end
