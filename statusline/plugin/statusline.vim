if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

let s:save_cpo = &cpo
set cpo&vim

let g:statusline_output_debug = get(g:, 'statusline_output_debug', 0)

set statusline=%{%statusline#output()%}

let &cpo = s:save_cpo
unlet s:save_cpo
