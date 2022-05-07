let s:modules = {
  \  'rel_path'              : 'modules#rel_path',
  \  'abs_path'              : 'modules#abs_path',
  \  'file_name'             : 'modules#file_name',
  \  'modifiable_mark'       : 'modules#modifiable_mark',
  \  'read_only'             : 'modules#read_only',
  \  'file_type'             : 'modules#file_type',
  \  'buffer_num'            : 'modules#buffer_num',
  \  'cursol_num'            : 'modules#cursol_num',
  \  'line_num'              : 'modules#line_num',
  \  'buffer_line_num'       : 'modules#buffer_lines_num',
  \  'file_position_percent' : 'modules#file_position_percent',
  \  'current_mode'          : 'modules#current_mode',
  \  }

function modules#get_modules() abort
  return s:modules
endfunction

function modules#call_moduler_func(moduler) abort
  return call(a:moduler, [])
endfunction

function! modules#rel_path() abort
  return "%f"
endfunction

function! modules#abs_path() abort
  return "%F"
endfunction

function! modules#file_name() abort
  return "%S"
endfunction

function! modules#modifiable_mark() abort
  return "%m"
endfunction

function! modules#read_only() abort
  return "%r"
endfunction

function! modules#file_type() abort
  return "%y"
endfunction

function! modules#buffer_num() abort
  return "%n"
endfunction

function! modules#cursol_num() abort
  return "%c"
endfunction

function! modules#line_num() abort
  return "%l"
endfunction

function! modules#buffer_lines_num() abort
  return "%L"
endfunction

function! modules#file_position_percent() abort
  return "%p"
endfunction

function! modules#current_mode() abort
  return mode()
endfunction
