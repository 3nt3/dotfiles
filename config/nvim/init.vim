set encoding=UTF-8

let mapleader = "\<Space>"
let localmapleader = ","

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'

Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'

Plug 'morhetz/gruvbox'

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " for LaTeX

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

Plug 'andys8/vim-elm-syntax' " elm syntax 

Plug 'drewtempelmeyer/palenight.vim'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc'

Plug 'dart-lang/dart-vim-plugin'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'archseer/colibri.vim'
Plug 'sainnhe/sonokai'

Plug 'LnL7/vim-nix' "nix syntax highlighting?

Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'turbio/bracey.vim'

Plug 'ap/vim-css-color'

" Initialize plugin system
call plug#end()

inoremap jk <ESC>
nmap <C-n> <plug>NERDTreeTabsToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         


let g:NERDTreeIgnore = ['^node_modules$']

autocmd FileType typescriptreact :setlocal sw=2 ts=2 sts=2


" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_cmd = 'CtrlPMixed'

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set nu
set mouse=a

set tabstop=4
set shiftwidth=4
" always uses spaces instead of tab characters
set expandtab


" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
" inoremap <silent><expr> <C-j>
"     \ coc#pum#visible() ? coc#pum#next(1):
"     \ <SID>check_back_space() ? "\<Tab>" :
"     \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocActionAsync('jumpDefinition', 'drop')
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

noremap <leader>F :'<,'>! prettier --parser html --stdin-filepath<cr>

augroup mygroup
  autocmd!
  " Setup formattexexpr specified filetype(s).
  autocmd FileType typescript,json,elm setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


let g:lsc_auto_map = v:true

nmap ; :Files<CR>
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" ts = 'number of spaces that <Tab> in file uses' sts = 'number of spaces that <Tab> uses while editing' sw = 'number of spaces to use for (auto)indent step' for details see: vimdoc.sourceforge.net/htmldoc/quickref.html#option-list – 
" --zdsbs on stackoverflow (https://stackoverflow.com/questions/1562633/setting-vim-whitespace-preferences-by-filetype)
autocmd FileType dart setlocal ts=2 sts=2 sw=2 expandtab

let g:dart_style_guide = 2
let g:dart_format_on_save = 1

set termguicolors
" set background=dark
colorscheme codedark
" hi Normal guibg=NONE ctermbg=NONE
let g:airline_theme = 'codedark'


" hot-reload on save
let g:flutter_hot_reload_on_save = 1
nmap <Leader>fs :CocCommand flutter.dev.hotRestart<CR>
nmap <Leader>fr :CocCommand flutter.run<cr> 
nmap <Leader>fq :CocCommand flutter.dev.quit<cr> 

nmap <Leader>w :w<CR>
nmap <Leader>cr :source ~/.config/nvim/init.vim<CR>
nmap <Leader>ce :tabedit ~/.config/nvim/init.vim<CR>

" autocmd FileType tex setl updatetime=1
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 1 

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab " two tabs for yaml

autocmd FileType svelte setlocal ts=2 sts=2 sw=2 expandtab " two tabs for yaml
autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab " two tabs for yaml

" allow exiting terminal using <Esc>
tnoremap <Esc> <C-\><C-n>

set splitbelow
set splitright

nmap <Leader>l :LLPStartPreview<CR>

autocmd FileType haskell,typescript setlocal ts=2 sts=2 sw=2 expandtab " two tabs for yaml

map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt

nmap <Leader>fR :CocCommand flutter.dev.hotRestart<cr> 
nmap <Leader>fo :CocCommand flutter.dev.openDevLog<cr>

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

nmap <Leader>CC :CocCommand<cr>
nmap <Leader>b :Buffers<cr>

nmap <Leader>T :term<cr>
