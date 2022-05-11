function! statusline#utils#resolve_mode_output(mode)
  return s:get_mode_output(a:mode[0])
endfunction

function! statusline#utils#resolve_mode_layout(mode_output)
  return s:get_mode_layout(a:mode_output)
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
function! s:get_mode_output(pre) abort
  " TODO 未定義のモードがある？
  return get(s:mode_outputs, a:pre, 'undefined')
endfunction

let s:mode_layouts = {
  \ 'normal' : 'statuslineterm',
  \ 'insert' : 'spellcap',
  \ 'visual' : 'wildmenu',
  \ 'visual-line' : 'wildmenu',
  \ 'replace' : 'errormsg',
  \ 'terminal' : 'spellcap',
  \ 'command' : 'spellcap',
  \ }
function! s:get_mode_layout(mode_output) abort
  " TODO デフォルトレイアウト
  return get(s:mode_layouts, a:mode_output, 'default')
endfunction
