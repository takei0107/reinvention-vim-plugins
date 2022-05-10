let s:mode_modules = {
  \  'n' : 'current_mode_n',
  \  'i' : 'current_mode_i',
  \  'v' : 'current_mode_v',
  \  'V' : 'current_mode_v_l',
  \  'R' : 'current_mode_r',
  \  'c' : 'current_mode_c',
  \  't' : 'current_mode_t',
  \}

function! statusline#utils#resolve_mode_module_name(mode)
  return s:get_mode_module_name(a:mode[0])
endfunction

function! s:get_mode_module_name(mode_prefix)
  return get(s:mode_modules, a:mode_prefix, 'undefined')
endfunction

