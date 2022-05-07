if exists('g:loaded_statusline')
  finish
endif
let g:loaded_statusline = 1

let s:save_cpo = &cpo
set cpo&vim

"set statusline=hogefugafoobar%f
set statusline=%{%statusline#output()%}

let &cpo = s:save_cpo
unlet s:save_cpo
