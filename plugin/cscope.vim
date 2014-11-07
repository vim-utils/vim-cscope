" ============================================================================
" File: cscope.vim
" Author: Bruno Sutic
" WebPage: https://github.com/bruno-/vim-cscope
" Original Source: http://cscope.sourceforge.net/cscope_vim_tutorial.html
" Content of this plugin is mostly a copy&paste from the original source.
" ============================================================================

if exists('g:loaded_cscope') && g:loaded_cscope
  finish
endif
let g:loaded_cscope = 1

if !has("cscope")
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" helper functions {{{1

function! s:cscopequickfix_option_not_edited()
  return &cscopequickfix ==# ""
endfunction

function! s:connect_to_cscope_db()
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

function! CscopeMappings(prefix, ...)
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

" cscope DB connection and mappings {{{1

call <SID>connect_to_cscope_db()

if s:cscopequickfix_option_not_edited()
  " most of the cscope results are shown in quickfix list
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" sets default mappings
if get(g:, 'cscope_default_mappings', 1)
  " mappings with no split
  call CscopeMappings("\<C-\>")
  " mappings with horizontal split
  call CscopeMappings("\<C-w>\<C-\>", "horizontal")
  call CscopeMappings("\<C-\@>", "horizontal")
  " mappings with vertical split
  call CscopeMappings("\<C-\@>\<C-\@>", "vertical")
endif

" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
