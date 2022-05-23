if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

let s:save_cpo = &cpo
set cpo&vim

" FIXME テスト用設定
function! Hoge() abort
  return "hoge"
endfunction
let g:statusline_custom_modules = {
  \ 'left' : ['file_encoding', 'file_format'],
  \ 'right' : ['current_mode', 'hoge'],
  \ 'modules_def' : {
  \   'hoge' : {
  \     'moduler' : "Hoge",
  \   }
  \ },
  \ 'modules_override' : {
  \   'file_format' : {
  \     'layout_group' : 'wildmenu',
  \   }
  \ }
  \ }

let g:statusline_output_debug = get(g:, 'statusline_output_debug', 0)
let g:statusline_custom_modules = get(g:, 'statusline_custom_modules', {})

set statusline=%{%statusline#output()%}

let &cpo = s:save_cpo
unlet s:save_cpo
