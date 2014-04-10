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


"set tags=./tags,tags,./tags.local
"syntax on
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
map _get_fns     :r!mkptypes %\|awk '/^[a-zA-Z]/{print $2}'
map _xvt         :!xvt %&<CR>
map _get_filename  qz:r!echo `basename %`<CR>"xyyuq
map _set_c       :set syntax=c<CR>
map _c           :set syntax=c<CR>
map _pl          :set syntax=perl<CR>
map _tcl         :set syntax=tcl<CR>
map _basic       :cal SetSyn("basic")<CR>
map _vb          :cal SetSyn("vb")<CR>
map _spell       :!aspell check %<CR>:e! %<CR>
map _jsyn        :cal SetSyn("java")<CR>
map _c++        :cal SetSyn("cpp")<CR>
map _+<space>       : s;\([0-9a-f]\{2,2}\);\1 ;gi<CR>
map _-<space>       : s;\([0-9a-f]\{2,2}\) ;\1;gi<CR>
map _+A<space>       : %s;\([0-9a-f]\{2,2}\);\1 ;gi<CR>
map _-A<space>       : %s;\([0-9a-f]\{2,2}\) ;\1;gi<CR>
map _-flip           :s;\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\)\([0-9a-f]\{2,2}\);\4\3\2\1;g
"map _indent :%!indent -bl -bli0 -i4 -l80 -nut -npsl -
map _indent :%!indent -bl -bli0 -i4  -nut -npsl -l120 -
"map _indent :%!indent -bl -bli0 -i4  -nut -npsl -l80 -
map qa          :qa<CR>
map _ccb            :%s,^[^\t]\+\t\([^\t]\+\t[^\t]\+\).*,\1,g


" key mappings which save off the previous search string buffer
" and then find an internal class method definition and then sets
" the search string buffer to the previous value
"map }} :let @j=@/<CR>j/^[ 	]\{2,4\}{<CR>:let @/=""<CR>:let @/=@j<CR>
"map {{ :let @j=@/<CR>k?^[ 	]\{2,4\}{<CR>:let @/=""<CR>:let @/=@j<CR>

map }} :let @j=@/<CR>j/^ *\(\w\+ \)\(\w\+[ \[\]]*\)\{1,10}(.*).*\n* *{<CR>:let @/=@j<CR>
map {{ :let @j=@/<CR>k?^ *\(\w\+ \)\(\w\+[ \[\]]*\)\{1,10}(.*).*\n* *{<CR>:let @/=@j<CR>

:inoremap # X#
set tags=tags,tags.jc
map vbfn /\*\{20,<CR>
"set guifont=-schumacher-clean-medium-r-normal-*-*-100-*-*-c-*-iso646.1991-irv
"set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
"set guifont=-adobe-courier-medium-r-normal-*-*-120-*-*-m-*-iso8859-9
map <C-r>   :redo<Esc>
map <A-l>   :tabn<CR>
map <A-k>   :tabn<CR>
map <A-h>   :tabp<CR>
map <A-j>   :tabp<CR>

"if v:ctype !~ "C"
"if &shell !~ "sh"
    "this is a windows instance
    "set guifont=6x13:h8
    "set guifont=Lucida_Console:h10:cANSI
    "set guifont=Lucida_Console:h8:cANSI
    set guifont=Courier_New:h8:cANSI 

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
    
" else
"     " this is a cygwin instance
"     "set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
"     "set guifont=Fixed\ 6
"     "set guifont=Monospace\ 6
"     "set guifont=Monospace\ 7
"     set guifont=Monospace\ 8
"     "set guifont==Fixed\ Semi-Condensed:8
"     " if you want side by side diffs, add 'vertical to diffopt
"     "set diffopt=iwhite,vertical
"     " horizontal is the up/down diffs
"     "set diffopt=iwhite
"     set diffopt=iwhite,filler,context:10000
"     "colorscheme elflord
" 
"     " if &term =~ "xterm"
"     "   if has("terminfo")
"     " 	set t_Co=8
"     " 	set t_Sf=<Esc>[3%p1%dm
"     " 	set t_Sb=<Esc>[4%p1%dm
"     "   else
"     " 	set t_Co=8
"     " 	set t_Sf=<Esc>[3%dm
"     " 	set t_Sb=<Esc>[4%dm
"     "   endif
"     " endif
" 	" :set t_AB=<Esc>[%?%p1%{8}%<%t25;%p1%{40}%+%e5;%p1%{32}%+%;%dm
" 	" :set t_AF=<Esc>[%?%p1%{8}%<%t22;%p1%{30}%+%e1;%p1%{22}%+%;%dm
" endif


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


set guioptions=amTtrbe
set mouse=nvc
set cwh=150
set vb
"let g:ccaseUseDialog=0	" Don't use dialog boxes
set lbr
set diffexpr=MyDiff()
" function MyDiff()
"    let opt = ""
"    if &diffopt =~ "icase"
"      let opt = opt . "-i "
"    endif
"    if &diffopt =~ "iwhite"
"      let opt = opt . "-w -B "
"    endif
"    silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new .
" 	\  " > " . v:fname_out
" endfunction

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

" command to set StartNumber to a value if it exists
:command -nargs=* StartNumber :call StartNumber(<f-args>)
" maps to number & set the start number to 1
map <F2> :call StartNumber()<CR>
map <F3> :call Number()<CR>j

" function to do a clearcase diff on the current branch
" "will by default do the predecessor
" or version 0 if a predecessor does not exist
" or against the supplied version number
" note, you can diff w/ newer versions too
:fu! Clt_diff_same_branch(...)
    let my_file = expand("%:p")
    if my_file !~ "@@"
        let my_file = system('cleartool ls -s ' . l:my_file)
        let my_file = substitute(l:my_file, ".CHECKEDOUT.*$","","")
        let my_file = substitute(l:my_file, "[\\\\]","/","g")
        "echo my_file
    else
        let my_file = substitute(l:my_file,"[\\\\/][0-9][^0-9]*$","","")
    endif
    "echo my_file
    "let my_prev_ver = expand("%:t")
    let my_prev_ver = my_file
    echo my_prev_ver
    if a:0 > 0
        if a:1 >= 0
            let my_prev_ver = a:1
        else 
            let my_prev_ver = 0
        endif
    else
        let my_prev_ver = my_prev_ver - 1
        if my_prev_ver < 0
            let my_prev_ver = 0
        endif
    endif
    let tmp = my_file . "/" . my_prev_ver
    echo "diffing vs. " . tmp
    exe ":diffsplit "tmp
endfu
" wrapper command for easier invocation
:command -nargs=* Ctb :call Clt_diff_same_branch(<f-args>)



" command to do a clearcase diff on another branch.
" if another branch is not supplied, it will diff
" against /main/LATEST
:fu! Clt_diff_other_branch(...)
    "let my_file = expand("%:h")
    let my_file = expand("%:p")
    let my_file = substitute(l:my_file,"[\\\\/][0-9][^0-9]*$","","")
    let my_file = substitute(l:my_file, "@@.*", "", "") 
    echo "this is my file: " . my_file

    " check the number of arguments
    if a:0 > 0
        let tmp = substitute(a:1, "\\","/", "g")
        let tmp = substitute(a:1, "'","", "g")
        let my_file = my_file . "@@/" . tmp
    else
        let my_file = my_file . "@@/main/LATEST"
    endif
    echo my_file
    exe ":diffsplit " my_file
endf
" wrapper command for easier invocation
:command -nargs=* Cto :call Clt_diff_other_branch(<f-args>)
    
" command to do a clearcase diff against another version on main
" if another branch is not supplied, it will diff
" against /main/LATEST
:fu! Clt_diff_main_branch(...)
    :let my_file = expand("%:h")
    let my_file = expand("%:p")
    let my_file = substitute(l:my_file,"[\\\\/][0-9][^0-9]*$","","")
    let my_file = substitute(l:my_file, "@@.*", "", "") 
    if a:0 > 0
        let my_file = my_file . "@@/main/" . a:1
    else
        let my_file = my_file . "@@/main/LATEST"
    endif
    echo my_file
    exe ":diffsplit " my_file
endf
" wrapper command for easier invocation
:command -nargs=* Ctm :call Clt_diff_main_branch(<f-args>)

" command to do a clearcase diff against this file with a tag
:fu! Clt_diff_tag(...)
    :let my_file = expand("%:h")
    let my_file = expand("%:p")
    let my_file = substitute(l:my_file,"[\\\\/][0-9][^0-9]*$","","")
    let my_file = substitute(l:my_file, "@@.*", "", "") 
    if a:0 > 0
        let my_file = my_file . "@@/" . a:1
    else
        let my_file = my_file . "@@/main/LATEST"
    endif
    echo my_file
    exe ":diffsplit " my_file
endf
" wrapper command for easier invocation
:command -nargs=* Ctt :call Clt_diff_tag(<f-args>)
map ctm :Ctm
map ctb :Ctb
map cto :Cto
map ctt :Ctt
    

fu! Get_file_name ()
    let fn = expand ("%")
    let fn = substitute(l:fn, "@@.*", "", "")
    let fn = substitute(l:fn, "^.*[\\/]", "", "")
    echo fn
    :r echo l:fn
endf

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
:command -nargs=* RN :call Remove_New(<f-args>)
syntax on
set nu


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



set lines=25 columns=120
set nowrap
nmap ,f :e ++ff=dos<CR>
