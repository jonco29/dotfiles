set ai
set smartindent
"set tabstop=60
set tabstop=4
set shiftwidth=4
set et
set ic
set nosm
set hls
set is
set mouse=""
set ru
set nrformats=hex,alpha
set ul=100
set nu
"set backupdir=d:/Temp
syntax on

autocmd VimResized * wincmd =
if &diff
    win 120 120
endif

"" goofy hack to make alt-l work for vim
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=50


hi Normal guibg=White guifg=Black
hi DiffText term=bold guibg=cyan guifg=black
" from the file: /users/jonco/share/vim/vim58/syntax/synload.vim
"  hi Comment    term=bold ctermfg=DarkBlue guifg=Blue
"  hi Constant   term=underline ctermfg=DarkRed guifg=Magenta
"  hi Special    term=bold ctermfg=DarkMagenta guifg=SlateBlue
"  hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
"  hi Statement  term=bold ctermfg=Brown gui=bold guifg=Brown
"  hi PreProc    term=underline ctermfg=DarkMagenta guifg=Purple
"  hi Type       term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
"  hi Ignore     ctermfg=white guifg=bg

"macros
let mapleader = "_"
noremap <leader>get_fns     :r!mkptypes %\|awk '/^[a-zA-Z]/{print $2}'
noremap <leader>xvt         :!xvt %&<CR>
noremap <leader>get_filename  qz:r!echo `basename %`<CR>"xyyuq
noremap <leader>set_c       :set syntax=c<CR>
noremap <leader>c           :set syntax=c<CR>
noremap <leader>pl          :set syntax=perl<CR>
noremap <leader>tcl         :set syntax=tcl<CR>
noremap <leader>basic       :cal SetSyn("basic")<CR>
noremap <leader>vb          :cal SetSyn("vb")<CR>
noremap <leader>spell       :!aspell check %<CR>:e! %<CR>
noremap <leader>jsyn        :cal SetSyn("java")<CR>
noremap <leader>c++        :cal SetSyn("cpp")<CR>
noremap <leader>+<space>       : s;\([0-9a-f]\{2,2}\);\1 ;gi<CR>
noremap <leader>-<space>       : s;\([0-9a-f]\{2,2}\) ;\1;gi<CR>
noremap <leader>+A<space>       : %s;\([0-9a-f]\{2,2}\);\1 ;gi<CR>
noremap <leader>-A<space>       : %s;\([0-9a-f]\{2,2}\) ;\1;gi<CR>
noremap <leader>-flip           :s;\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\);\4\3\2\1;g
noremap qa          :qa<CR>


" key mappings which save off the previous search string buffer
" and then find an internal class method definition and then sets
" the search string buffer to the previous value
"map }} :let @j=@/<CR>j/^[ 	]\{2,4\}{<CR>:let @/=""<CR>:let @/=@j<CR>
"map {{ :let @j=@/<CR>k?^[ 	]\{2,4\}{<CR>:let @/=""<CR>:let @/=@j<CR>

noremap }} :let @j=@/<CR>j/^ *\(\w\+ \)\(\w\+[ \[\]]*\)\{1,10}(.*).*\n* *{<CR>:let @/=@j<CR>
noremap {{ :let @j=@/<CR>k?^ *\(\w\+ \)\(\w\+[ \[\]]*\)\{1,10}(.*).*\n* *{<CR>:let @/=@j<CR>

:inoremap # X#
set tags=tags,tags.jc
noremap vbfn /\*\{20,<CR>
noremap <C-r>   :redo<Esc>
"noremap <A-l>   :tabn<CR>
"noremap <A-k>   :tabn<CR>
"noremap <A-h>   :tabp<CR>
"noremap <A-j>   :tabp<CR>

fu! Get_file_name ()
    let fn = expand ("%")
    let fn = substitute(l:fn, "@@.*", "", "")
    let fn = substitute(l:fn, "^.*[\\/]", "", "")
    redir @q
    echo fn
    redir END
    :put q
endf

"echo ">^.^<"
" vimscript stuff
nnoremap <c-u> viwU<esc>
inoremap <c-u> <esc><c-u>
inoremap jk <esc>

" "boxr
" let g:mediawiki_editor_url = 'boxr.am.mot.com'
" let g:mediawiki_editor_path = '/jconway/wiki/'
" let g:mediawiki_editor_username = 'jonco'
"let g:mediawiki_editor_uri_scheme = 'http'

" "private
" let g:mediawiki_editor_url = 'localhost'
" let g:mediawiki_editor_path = '/~jonco/wiki/'
" let g:mediawiki_editor_username = 'jonco'

" "private 2
" let g:mediawiki_editor_url = 'jc-mint.am.mot.com'
" let g:mediawiki_editor_path = '/~jonco/wiki/'
" let g:mediawiki_editor_username = 'jonco'

""moti wiki
"let g:mediawiki_editor_url = 'jonco.duckdns.org'
"let g:mediawiki_editor_path = '/moti-wiki/'
"let g:mediawiki_editor_username = 'jonco'

" "home wiki
let g:mediawiki_editor_url = 'jonco-wiki.duckdns.org'
let g:mediawiki_editor_path = '/wiki/'
let g:mediawiki_editor_username = 'jonco'

" "pw wiki
"let g:mediawiki_editor_url = 'jonco-wiki.duckdns.org'
"let g:mediawiki_editor_path = '/pw/'
"let g:mediawiki_editor_username = 'jonco'

nmap ,f :e ++ff=dos<CR>

