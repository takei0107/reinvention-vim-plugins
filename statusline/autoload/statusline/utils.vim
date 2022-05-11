function! statusline#utils#resolve_mode_module(current_mode)
  return s:get_current_mode_output(a:current_mode[0])
endfunction

" TODO このオブジェクトの設置場所考える
" TODO オブジェクトの内容を動的にする？
let s:mode_outputs = {
  \ 'n' : 'normal',
  \ 'i' : 'insert',
  \ 'v' : 'visual',
  \ 'V' : 'visual-line',
  \ 'r' : 'replace',
  \ 't' : 'terminal',
  \ 'c' : 'command',
  \}
function! s:get_current_mode_output(pre) abort
  " TODO 未定義のモードがある？
  return get(s:mode_outputs, a:pre, 'undefined')
endfunction
