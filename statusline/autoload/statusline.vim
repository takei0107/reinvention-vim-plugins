function! statusline#output() abort
  return s:build_output()
endfunction

function! s:build_output() abort
  let line = []
  for moduler in s:aggregate_modulers()
    call add(line, statusline#modules#call_moduler_func(moduler))
  endfor
  return join(line, "\ ")
endfunction

" TODO 利用するモジュールの決定
let s:target_modules = ['current_mode', 'cursol_num', 'file_position_percent']

function! s:aggregate_modulers() abort
  let modulers = []
  for module_nane in s:target_modules
    let moduler = s:resolve_moduler(module_nane)
    if moduler !=# 'undefined'
      call add(modulers, moduler)
    endif
  endfor
  return modulers
endfunctio

function! s:resolve_moduler(module_name) abort
  let module = get(statusline#modules#get_modules(), a:module_name, {})
  return get(module, 'moduler', 'undefined')
endfunction
