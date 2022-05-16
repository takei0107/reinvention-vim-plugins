let s:modules = {
  \  'rel_path'              : {'moduler' : 'statusline#modules#rel_path'},
  \  'abs_path'              : {'moduler' : 'statusline#modules#abs_path'},
  \  'file_name'             : {'moduler' : 'statusline#modules#file_name'},
  \  'modifiable_mark'       : {'moduler' : 'statusline#modules#modifiable_mark'},
  \  'read_only'             : {'moduler' : 'statusline#modules#read_only'},
  \  'file_type'             : {'moduler' : 'statusline#modules#file_type'},
  \  'buffer_num'            : {'moduler' : 'statusline#modules#buffer_num'},
  \  'cursol_num'            : {'moduler' : 'statusline#modules#cursol_num'},
  \  'line_num'              : {'moduler' : 'statusline#modules#line_num'},
  \  'buffer_line_num'       : {'moduler' : 'statusline#modules#buffer_lines_num'},
  \  'file_position_percent' : {'moduler' : 'statusline#modules#file_position_percent'},
  \  'current_mode'          : {
  \                              'moduler' : 'statusline#modules#current_mode',
  \                              'layout_group' : 'difftext',
  \                              'layout_func' : "\<SID>layout_current_mode"
  \                            },
  \  'file_encoding'          : {'moduler' : 'statusline#modules#file_encoding'},
  \  }

function! statusline#modules#get_modules() abort
  return s:modules
endfunction

function! statusline#modules#resolve_moduler(module) abort
  return get(a:module, 'moduler', 'undefined')
endfunction

function! s:call_moduler_func(moduler_func) abort
  if a:moduler_func !=# 'undefined'
    return call(a:moduler_func, [])
  else
    return ''
  endif
endfunction

function! s:call_layout_func(layout_func, moduler_output) abort
  return call(a:layout_func, [a:moduler_output])
endfunction

function! s:build_layout(module, moduler_output) abort
  if has_key(a:module, 'layout_func')
    let layout_group = s:call_layout_func(get(a:module, 'layout_func'), a:moduler_output)
  else
    let layout_group = get(a:module, 'layout_group', 'default')
  endif
  return "%#" . layout_group . "#"
endfunction

function! statusline#modules#output(module) abort
  let moduler = statusline#modules#resolve_moduler(a:module)
  let moduler_output = s:call_moduler_func(moduler)
  let layout_output = s:build_layout(a:module, moduler_output)
  return layout_output . ' ' . moduler_output
endfunction

function! statusline#modules#rel_path() abort
  return "%f"
endfunction

function! statusline#modules#abs_path() abort
  return "%F"
endfunction

function! statusline#modules#file_name() abort
  return "%t"
endfunction

function! statusline#modules#modifiable_mark() abort
  return "%m"
endfunction

function! statusline#modules#read_only() abort
  return "%r"
endfunction

function! statusline#modules#file_type() abort
  return "%y"
endfunction

function! statusline#modules#buffer_num() abort
  return "%n"
endfunction

function! statusline#modules#cursol_num() abort
  return "%c"
endfunction

function! statusline#modules#line_num() abort
  return "%l"
endfunction

function! statusline#modules#buffer_lines_num() abort
  return "%L"
endfunction

function! statusline#modules#file_position_percent() abort
  return "%p"
endfunction

function! statusline#modules#file_encoding() abort
  let encoding = !empty(&fileencoding) ? &fileencoding : &encoding
  return "%\\" . encoding
endfunction

function! statusline#modules#current_mode() abort
  return statusline#utils#resolve_mode_output(mode())
endfunction

function! s:layout_current_mode(moduler_output) abort
  return statusline#utils#resolve_mode_layout(a:moduler_output)
endfunction
