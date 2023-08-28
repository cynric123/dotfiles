" my first .vimrc file @macos

""""""""""""""""""""""
"    Dependencies    "
""""""""""""""""""""""
" All packages were installed using Homebrew on OSX.

" Vim with python support enabled.
" vundle - Package manager.
" fzf - Fuzzy Finder, fast list search for key words.
" rg - RipGrep, improved grep; used in fzf instead of grep.
" yarn - Used in coc.vim folder to compile the plugin.
" git - Used in vim-fugitive.
" th_en_US_v2 - Any valid thesaurus will do.

"""""""""""""""""
"    Plugins    "
"""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-commentary' "gc
" Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround' "ys
"Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'christoomey/vim-titlecase' "gz
" Plugin 'christoomey/vim-sort-motion' "gs
" Plugin 'ludovicchabant/vim-gutentags' "tag generation
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'airblade/vim-rooter' "makes sure fzf has project scope
Plugin 'junegunn/goyo.vim' "distraction free mode
Plugin 'junegunn/limelight.vim' "selective highlighting
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline' "fancier status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/vim-pencil'
Plugin 'Ron89/thesaurus_query.vim'
Plugin 'neoclide/coc.nvim', { 'branch': 'release' }
"Plugin 'neoclide/coc-snippets'
"Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set nocompatible  " be iMproved, required
syntax on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""
"    Plugin Settings   "
""""""""""""""""""""""""
"" vim-pencil
augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init()
	autocmd FileType text         call pencil#init()
augroup END

"" thesaurus_query options
" activate with <leader>cs
let g:tq_openoffice_en_file="/usr/share/mythes/th_en_US_v2"

"" snippets

let snips_author = "Alex Martin"
let snips_email = "cynric123@gmail.com"
let snips_github = "cynric123"

"" Coc.vim

" Change the CoC autocomplete menu to a less obtrusive color
function! s:my_colors_setup() abort
	highlight CocSearch ctermfg=109 guifg=#83a598
endfunction

augroup colorscheme_coc_setup | au!
	au Colorscheme * call s:my_colors_setup()
augroup END

" Used when pressing tab in insert mode.
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" SHIFT+K functionality
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#coc#enabled = 1

"" Gutentags
" create a tag cache to store all tags
" let g:gutentags_cache_dir="~/.tags_cache"

"" fzf
" use fd instead of Find
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" let $FZF_DEFAULT_OPTS = ''

"" vimwiki
" set root directory
let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" don't treat all markdown files as part of vimwiki
let g:vimwiki_global_ext = 0

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

""""""""""""""""""""""""""""""""""
"    Colorscheme/UI Modifiers    "
""""""""""""""""""""""""""""""""""

"filetype off      " required

set background=dark
autocmd vimenter * ++nested colorscheme gruvbox

set showmatch               " show matching bracket
set tabstop=4               " Change tab to spaces
set shiftwidth=4            " indent size
set number                  " show line number
set showcmd                 " show commands
set autoindent
set smartindent
set lazyredraw              " don't redraw in macros
set wildmenu                " enable completion detection
set path+=*                 " include current directory on path
set confirm                 " prompt user to save unsaved files
set hidden                  " hides buffer instead of unloads on close
set relativenumber          " number of lines between nearby lines
set hlsearch                " highlight search
set ignorecase              " case insensitive
set incsearch               " show results as you type
set splitbelow              " new splits go down
set splitright              " new splits go right
set noswapfile              " removes extra file copy
set wrap                    " softwrap full words
set linebreak
set list
set listchars=eol:¬,tab:\|\ " show certain special characters
set cmdheight=2
set signcolumn=yes          " set signcolumn=number "merges sign and number
set updatetime=300
set shortmess+=c            " Don't pass messages to ins-completion-menu.

""""""""""""""""""""""""""
"    Keybinds/Scripts    "
""""""""""""""""""""""""""
"" Generic mapping

" leader key
let mapleader=" " " map leader to space

" <space>rc to edit this file
map <leader>rc :tabe $MYVIMRC<cr>

" run :Rg
map <silent> <leader>rg :Rg<CR>

" replace grep with ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow\

" leader+h removes search highlight
map <silent> <leader>h :noh<CR>

" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i

" type 'jk' instead of <ESC>
inoremap jk <ESC>
" Auto generate tags file on file write of *.c and *.h files
" autocmd BufWritePost *.c,*.h silent! !ctags . &
"
" turn on spell check for markdown files
autocmd FileType markdown setlocal spell spelllang=en

"" Goyo
nnoremap <silent><Leader>gy :Goyo<CR>
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!

"" fzf.vim
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <silent> <leader>f :Files<CR>
nmap <silent> <leader>b :Buffers<CR>

nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

"" Coc.vim
" Each subfold contains keybind context.
""" use <leader>rn to rename symbol.
nmap <leader>rn <Plug>(coc-rename)

""" Use <ctrl->f to Format selected code.
xmap <c-f>  <Plug>(coc-format-selected)
nmap <c-f>  <Plug>(coc-format-selected)

""" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ coc#pum#visible() ? coc#pum#next(1):
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

""" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
""" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

""" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

""" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
"
""" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

""" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

""" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
" 	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" 	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" 	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" 	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" 	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" 	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

""" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

""" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"" Make adjusting split sizes a bit more friendly
" Taken from DistroTube's .vimrc
" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

noremap <silent> <S-Left> :vertical resize +3<CR>
noremap <silent> <S-Right> :vertical resize -3<CR>
noremap <silent> <S-Up> :resize +3<CR>
noremap <silent> <S-Down> :resize -3<CR>

"" Paste the date at cursor
nnoremap <silent> <leader>now "=strftime("%c")<CR>P

"" Autofolding .vimrc
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
" thanks to cbaumhardt on Stack Exchange for supplying this code.

""" defines a foldlevel for each line of code
function! VimFolds(lnum)
	let s:thisline = getline(a:lnum)
	if match(s:thisline, '^"" ') >= 0
		return '>2'
	endif
	if match(s:thisline, '^""" ') >= 0
		return '>3'
	endif
	let s:two_following_lines = 0
	if line(a:lnum) + 2 <= line('$')
		let s:line_1_after = getline(a:lnum+1)
		let s:line_2_after = getline(a:lnum+2)
		let s:two_following_lines = 1
	endif
	if !s:two_following_lines
		return '='
	endif
  else
	  if (match(s:thisline, '^"""""') >= 0) &&
				  \ (match(s:line_1_after, '^"  ') >= 0) &&
				  \ (match(s:line_2_after, '^""""') >= 0)
		  return '>1'
	  else
		  return '='
	  endif
  endif
endfunction

""" defines a foldtext
function! VimFoldText()
	" handle special case of normal comment first
	let s:info = '('.string(v:foldend-v:foldstart).' l)'
	if v:foldlevel == 1
		let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
	elseif v:foldlevel == 2
		let s:line = '   ●  '.getline(v:foldstart)[3:]
	elseif v:foldlevel == 3
		let s:line = '     ▪ '.getline(v:foldstart)[4:]
	endif
	if strwidth(s:line) > 80 - len(s:info) - 3
		return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
	else
		return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
	endif
endfunction

""" set foldsettings automatically for vim files
augroup fold_vimrc
	autocmd!
	autocmd FileType vim
				\ setlocal foldmethod=expr |
				\ setlocal foldexpr=VimFolds(v:lnum) |
				\ setlocal foldtext=VimFoldText() |
	"              \ set foldcolumn=2 foldminlines=2
augroup END
