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

call cscope#connect_to_db()

if cscope#quickfix_option_not_edited()
  " most of the cscope results are shown in quickfix list
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" sets default mappings
if get(g:, 'cscope_default_mappings', 1)
  " mappings with no split
  call cscope#mappings("\<C-\>")
  " mappings with horizontal split
  call cscope#mappings("\<C-w>\<C-\>", "horizontal")
  call cscope#mappings("\<C-\@>", "horizontal")
  " mappings with vertical split
  call cscope#mappings("\<C-\@>\<C-\@>", "vertical")
endif

let &cpo = s:save_cpo
unlet s:save_cpo
