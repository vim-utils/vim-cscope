function! cscope#quickfix_option_not_edited()
  return &cscopequickfix ==# ""
endfunction

function! cscope#connect_to_db()
  " add cscope DB in current dir
  if filereadable("cscope.out")
    cscope kill -1
    cscope add cscope.out
  " else add the DB pointed to by ENV var
  elseif $CSCOPE_DB != ""
    cscope kill -1
    cscope add $CSCOPE_DB
  endif
endfunction

" cscope mappings C-\ (similar to C-] for ctags)
function! s:cscope_mappings(prefix, cscope_command)
  exec "nnoremap \<silent> ".a:prefix."s :".a:cscope_command." find s \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."g :".a:cscope_command." find g \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."c :".a:cscope_command." find c \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."t :".a:cscope_command." find t \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."e :".a:cscope_command." find e \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."f :".a:cscope_command." find f \<C-R>=expand(\"<cfile>\")\<CR>\<CR>"
  exec "nnoremap \<silent> ".a:prefix."i :".a:cscope_command." find i ^\<C-R>=expand(\"<cfile>\")\<CR>$\<CR>"
  exec "nnoremap \<silent> ".a:prefix."d :".a:cscope_command." find d \<C-R>=expand(\"<cword>\")\<CR>\<CR>"
endfunction

function! cscope#mappings(prefix, ...)
  if a:0
    let split = a:1
  else
    let split = "nosplit"
  endif
  if split ==# "nosplit"
    call <SID>cscope_mappings(a:prefix, "cscope")
  elseif split ==# "horizontal"
    call <SID>cscope_mappings(a:prefix, "scscope")
  elseif split ==# "vertical"
    call <SID>cscope_mappings(a:prefix, "vert scscope")
  endif
endfunction
