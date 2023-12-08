call plug#begin('~/.config/nvim/plugged')
" Colorscheme
Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" General
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'dyng/ctrlsf.vim'

" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" :CocInstall coc-angular
" :CocInstall tsserver
" :CocInstall coc-eslint
" :CocInstall pyright
" :CocInstall coc-json
" :CocInstall coc-clangd
" :CocInstall coc-diagnostic
" :CocInstall coc-yaml

Plug 'vim-test/vim-test'
Plug 'neomake/neomake'
Plug 'preservim/vimux'

" File explorer
Plug 'lambdalisue/fern.vim'

" JS/TS
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'softoika/ngswitcher.vim'
Plug 'davidosomething/format-ts-errors.nvim'

" Diff
Plug 'rickhowe/diffchar.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'rickhowe/spotdiff.vim'
Plug 'whiteinge/diffconflicts'

" Bash colors
Plug 'chrisbra/Colorizer'
Plug 'powerman/vim-plugin-AnsiEsc'

" Debugging
Plug 'puremourning/vimspector'

call plug#end()

""" Tabs
set tabstop=4
set shiftwidth=4
set expandtab

autocmd FileType html,scss setlocal shiftwidth=2 softtabstop=2 expandtab

""" Appearance
colorscheme solarized
let g:solarized_termcolors=256
set background=light
syntax enable
set number
set encoding=UTF-8


""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

""" Html autocompletion
autocmd FileType css,scss setlocal iskeyword+=-,?,!
autocmd FileType html setlocal iskeyword+=-

""" CoC
let g:coc_node_args = ['--max-old-space-size=1024']

nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> g<Tab> :call CocAction('jumpDefinition', 'tabe')<CR>
map <leader>, :CocCommand clangd.switchSourceHeader<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> <leader>] <Plug>(coc-definition)
nmap <silent> <leader>[ <Plug>(coc-references)

nmap <leader>F <Plug>(coc-fix-current)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call <SID>show_documentation()<CR>

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" Opening files
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
au BufNewFile,BufRead Dockerfile.* set filetype=dockerfile
au BufNewFile,BufRead Jenkinsfile* set filetype=groovy

""" Angular files switch

nnoremap <Leader>u :<C-u>NgSwitchTS<CR>
nnoremap <Leader>i :<C-u>NgSwitchCSS<CR>
nnoremap <Leader>o :<C-u>NgSwitchHTML<CR>
nnoremap <Leader>p :<C-u>NgSwitchSpec<CR>

" with horizontal split
nnoremap <leader>su :<C-u>SNgSwitchTS<CR>
nnoremap <leader>si :<C-u>SNgSwitchCSS<CR>
nnoremap <leader>so :<C-u>SNgSwitchHTML<CR>
nnoremap <leader>sp :<C-u>SNgSwitchSpec<CR>

" with vertical split
nnoremap <leader>vu :<C-u>VNgSwitchTS<CR>
nnoremap <leader>vi :<C-u>VNgSwitchCSS<CR>
nnoremap <leader>vo :<C-u>VNgSwitchHTML<CR>
nnoremap <leader>vp :<C-u>VNgSwitchSpec<CR>

""" Grep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)
nmap <C-P> :GF<CR>

""" Vim diff
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set diffopt+=iwhite

""" CTRLSF

" Search
nmap <leader>t :CtrlSFToggle<CR>

" Visual multi with CTRLSF
autocmd FileType ctrlsf nmap <leader>n <Plug>(VM-Find-Under)


""" Find files
set path+=**
set wildmenu

set mouse=

let g:netrw_banner = 0


""" FERN navigation
" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

noremap <silent> <Leader>f :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> % <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> - <Plug>(fern-action-mark:toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

""" Linters
let g:ale_disable_lsp = 1
let g:ale_fixers = {'python': ['black', 'autopep8', 'autoflake'], 'typescript': ['eslint', 'prettier'], 'javascript': ['eslint', 'prettier'], 'cpp': ['clang-format']}
let g:ale_javascript_eslint_options = ""
let g:ale_typescript_eslint_options = ""
let g:ale_javascript_eslint_suppress_eslintignore = 1


""" Debugging stuff
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
inoremap <silent> ,s <C-r>=CocActionAsync('showSignatureHelp')<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver
