function! utils#convert_mode_str(mode) 
  let pre = a:mode[0]
  return s:resolve_mode_str(pre)
endfunction

let s:mode_marks = {
  \  'n' : 'normal',
  \  'i' : 'insert',
  \  'v' : 'visual',
  \  'V' : 'visual-line',
  \  'R' : 'replace',
  \  'c' : 'command',
  \  't' : 'terminal',
  \}
function! s:resolve_mode_str(mode_prefix)
  return get(s:mode_marks, a:mode_prefix, 'undifined')
endfunction
