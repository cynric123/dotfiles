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

"" keystroke commands
Plugin 'tpope/vim-commentary' "gc
" Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround' "ys
"Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'christoomey/vim-titlecase' "gz
" Plugin 'christoomey/vim-sort-motion' "gs

"" file navigation
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'airblade/vim-rooter' "makes sure fzf has project scope

"" writing/interface
Plugin 'junegunn/goyo.vim' "distraction free mode
Plugin 'junegunn/limelight.vim' "selective highlighting
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline' "fancier status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/vim-pencil'
Plugin 'Ron89/thesaurus_query.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'lervag/vimtex'

"" programming
" Plugin 'ludovicchabant/vim-gutentags' "tag generation
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Plugin 'neoclide/coc.nvim', { 'branch': 'release' }

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

"" thesaurus query
" prevent screen from clogging up with results
" press A<enter> to generate complete list
let g:tq_truncation_on_syno_list_size = 200
let g:tq_truncation_on_definition_num = 3

"" snippets

let snips_author = "Alex Martin"
let snips_email = "amartin413@protonmail.com"
let snips_github = "cynric123"

"" Coc.vim

" function! s:my_colors_setup() abort
" 	highlight CocSearch ctermfg=109 guifg=#83a598
" endfunction

" augroup colorscheme_coc_setup | au!
" 	au Colorscheme * call s:my_colors_setup()
" augroup END

" " Used when pressing tab in insert mode.
" function! CheckBackspace() abort
" 	let col = col('.') - 1
" 	return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " SHIFT+K functionality
" function! ShowDocumentation()
" 	if CocAction('hasProvider', 'hover')
" 		call CocActionAsync('doHover')
" 	else
" 		call feedkeys('K', 'in')
" 	endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" augroup mygroup
" 	autocmd!
" 	" Setup formatexpr specified filetype(s).
" 	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" 	" Update signature help on jump placeholder.
" 	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocActionAsync('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" let g:airline#extensions#coc#enabled = 1

"" Gutentags
" create a tag cache to store all tags
" let g:gutentags_cache_dir="~/.tags_cache"

"" fzf
" use fd instead of Find
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" let $FZF_DEFAULT_OPTS = ''

" initialize configuration dictionary
let g:fzf_vim = {}

"" vimwiki
" set root directory
let g:vimwiki_list = [{'path': '~/notes/',
					\ 'syntax': 'markdown', 
					\ 'ext': '.md',
					\ 'auto_generate_tags': 1,
					\ 'auto_toc': 1}]

" don't treat all markdown files as part of vimwiki
let g:vimwiki_global_ext = 0

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end

"" VimTeX


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
"" generic mapping

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

" turn on spell check for markdown files
autocmd FileType markdown setlocal spell spelllang=en

"" goyo
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
" imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <silent> <leader>f :Files<CR>
nmap <silent> <leader>b :Buffers<CR>

" toggle fzf preview window with ctrl-p
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-p']

" vim word autocomplete
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 


"" Ultisnips
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"" VimWiki
" nmap <Leader>wx <Plug>VimwikiIndex

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



