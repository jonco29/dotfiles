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
"set backupdir=d:/Temp
set nu
set guioptions=amTtrbe
set mouse=nvc
set cwh=150
set vb
set lbr
syntax on

autocmd VimResized * wincmd =
if &diff
    win 120 120
endif



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
"map _indent :%!indent -bl -bli0 -i4 -l80 -nut -npsl -
noremap <leader>indent :%!indent -bl -bli0 -i4  -nut -npsl -l120 -
"map _indent :%!indent -bl -bli0 -i4  -nut -npsl -l80 -
noremap qa          :qa<CR>
noremap <leader>ccb            :%s,^[^\t]\+\t\([^\t]\+\t[^\t]\+\).*,\1,g


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
noremap <A-l>   :tabn<CR>
noremap <A-k>   :tabn<CR>
noremap <A-h>   :tabp<CR>
noremap <A-j>   :tabp<CR>

"if v:ctype !~ "C"
if &shell !~ "sh"
    "this is a windows instance
    "set guifont=6x13:h8
    set guifont=Lucida_Console:h10:cANSI
    set mouse=a
    set sh=cmd.exe
    set shellcmdflag=/C
    " if you want side by side diffs, add 'vertical to diffopt
    "set diffopt=iwhite,vertical
    " horizontal is the up/down diffs
    "set diffopt=iwhite
    "filler sets the fill
    "context is # of lines between diff threshold before folding
    set diffopt=iwhite,filler,context:10000
    
else
    " this is a cygwin instance
    "set guifont=Monospace\ 7
    set guifont=Monospace\ 10
    " if you want side by side diffs, add 'vertical to diffopt
    "set diffopt=iwhite,vertical
    " horizontal is the up/down diffs
    "set diffopt=iwhite
    set diffopt=iwhite,filler,context:10000
endif


" latex-vim changes
" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on


" function to start numbering
let g:jc_current_number = 1
fu! StartNumber(...)
    if a:0 > 0
        let g:jc_current_number = a:1
    else
        let g:jc_current_number = inputdialog("Enter a starting number", "1")
        if g:jc_current_number == ""
            let g:jc_current_number = 1
        endif
    endif
endf
" function to number, using the number set from start number
fu! Number()
    if g:jc_current_number < 10
        let s:i = "0" . g:jc_current_number
        exe ":s,^,"s:i" ,"
    else
        exe ":s,^,"g:jc_current_number" ,"
    endif
    let g:jc_current_number = g:jc_current_number + 1
endf

"" command to set StartNumber to a value if it exists
":command -nargs=* StartNumber :call StartNumber(<f-args>)
"" maps to number & set the start number to 1
noremap <F2> :call StartNumber()<CR>
noremap <F3> :call Number()<CR>j


" if insert mode is set, do these
if &insertmode
    amenu Jonathan.add_space i<C-L>_+<SPACE>
    amenu Jonathan.remove_space i<C-L>_-<SPACE>
    amenu Jonathan.jump_to_definition i<C-L><C-]>
    amenu Jonathan.jump_back i<C-L><C-t>
else
    amenu Jonathan.add_space _+<SPACE>
    amenu Jonathan.remove_space _-<SPACE>
    amenu Jonathan.jump_to_definition <C-]>
    amenu Jonathan.jump_back <C-t>
    amenu Jonathan.Load_Cscope :CCTreeLoadDB<CR>
    amenu Jonathan.forward_call_tree <C-\>>
    amenu Jonathan.backward_call_tree <C-\><

    amenu   1.1 PopUp.jump\ to\ definition <C-]>
    amenu   1.2 PopUp.jump\ back <C-t>
    an      1.3 PopUp.------------  <Nop>
    amenu   1.4 PopUp.add\ space _+<SPACE>
    amenu   1.5 PopUp.remove\ space _-<SPACE>
    an      1.6 PopUp.------------  <Nop>
    amenu   1.7 PopUp.Load\ Cscope :CCTreeLoadDB<CR><CR>
    amenu   1.8 PopUp.forward\ call\ tree <C-\>>
    amenu   1.9 PopUp.backwards\ call\ tree <C-\><
    an      1.10 PopUp.------------  <Nop>
endif
set mousemodel=popup_setpos

if has("terminfo")
  set t_Co=16
  set t_AB=<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
  set t_AF=<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
else
  set t_Co=16
  set t_Sf=<Esc>[3%dm
  set t_Sb=<Esc>[4%dm
endif


" command to change from .txt.new to .txt
:fu! Remove_New(...)
    :let my_file = expand("%:r")
    echo my_file
    exe ":f " my_file
endf
" wrapper command for easier invocation
:command! -nargs=* RN :call Remove_New(<f-args>)


"set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

"" "echo ">^.^<"
"" " vimscript stuff
"" nnoremap <c-u> viwU<esc>
"" inoremap <c-u> <esc><c-u>
"" inoremap jk <esc>

" ""auto commands to format when writing
" "augroup format_write
" "    autocmd!
" "    autocmd BufWritePre *.html :normal gg=G
" "    autocmd BufWritePre *.[ch] :normal gg=G
" "augroup END
" 
" autocmd FileType python :iabbrev <buffer> iff if:<left>
" autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

"" " "boxr
"" " let g:mediawiki_editor_url = 'boxr.am.mot.com'
"" " let g:mediawiki_editor_path = '/jconway/wiki/'
"" " let g:mediawiki_editor_username = 'jonco'
"" "let g:mediawiki_editor_uri_scheme = 'http'
"" 
"" " "private
"" " let g:mediawiki_editor_url = 'localhost'
"" " let g:mediawiki_editor_path = '/~jonco/wiki/'
"" " let g:mediawiki_editor_username = 'jonco'
"" 
"" " "private 2
"" " let g:mediawiki_editor_url = 'jc-mint.am.mot.com'
"" " let g:mediawiki_editor_path = '/~jonco/wiki/'
"" " let g:mediawiki_editor_username = 'jonco'
"" 
"" ""moti wiki
"" "let g:mediawiki_editor_url = 'jonco.duckdns.org'
"" "let g:mediawiki_editor_path = '/moti-wiki/'
"" "let g:mediawiki_editor_username = 'jonco'
"" 
"" " "home wiki
"" let g:mediawiki_editor_url = 'jonco-wiki.duckdns.org'
"" let g:mediawiki_editor_path = '/wiki/'
"" let g:mediawiki_editor_username = 'jonco'
"" 
"" " "pw wiki
"" "let g:mediawiki_editor_url = 'jonco-wiki.duckdns.org'
"" "let g:mediawiki_editor_path = '/pw/'
"" "let g:mediawiki_editor_username = 'jonco'
"" 
"" nmap ,f :e ++ff=dos<CR>
"" 
