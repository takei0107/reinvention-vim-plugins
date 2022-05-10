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
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_n'        : {
  \                              'moduler' : 'statusline#modules#current_mode_normal',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_i'        : {
  \                              'moduler' : 'statusline#modules#current_mode_insert',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_v'        : {
  \                              'moduler' : 'statusline#modules#current_mode_visual',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_v_l'      : {
  \                              'moduler' : 'statusline#modules#current_mode_visual_line',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_r'        : {
  \                              'moduler' : 'statusline#modules#current_mode_replace',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_t'        : {
  \                              'moduler' : 'statusline#modules#current_mode_terminal',
  \                              'layout_group' : 'difftext'
  \                            },
  \  'current_mode_c'        : {
  \                              'moduler' : 'statusline#modules#current_mode_command',
  \                              'layout_group' : 'difftext'
  \                            },
  \  }

function! statusline#modules#get_modules() abort
  return s:modules
endfunction

function! statusline#modules#resolve_moduler(module) abort
  return get(a:module, 'moduler', 'undefined')
endfunction

function statusline#modules#call_moduler_func(moduler) abort
  if a:moduler !=# 'undefined'
    return call(a:moduler, [])
  else
    return ''
  endif
endfunction

function! statusline#modules#rel_path() abort
  return "%f"
endfunction

function! statusline#modules#abs_path() abort
  return "%F"
endfunction

function! statusline#modules#file_name() abort
  return "%S"
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

function! statusline#modules#current_mode() abort
  let mode_module_name = statusline#utils#resolve_mode_module_name(mode())
  let module = get(s:modules, mode_module_name, 'undefined')
  let moduler = statusline#modules#resolve_moduler(module)
  return statusline#modules#call_moduler_func(moduler)
endfunction

function! statusline#modules#current_mode_normal() abort
  return "normal"
endfunction

function! statusline#modules#current_mode_insert() abort
  return "insert"
endfunction

function! statusline#modules#current_mode_visual() abort
  return "visual"
endfunction

function! statusline#modules#current_mode_visual_line() abort
  return "visual-line"
endfunction

function! statusline#modules#current_mode_replace() abort
  return "replace"
endfunction

function! statusline#modules#current_mode_command() abort
  return "command"
endfunction

function! statusline#modules#current_mode_terminal() abort
  return "terminal"
endfunction
