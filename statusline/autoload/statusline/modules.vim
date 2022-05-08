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
  \  }

function statusline#modules#get_modules() abort
  return s:modules
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
  return statusline#utils#convert_mode_str(mode())
endfunction
