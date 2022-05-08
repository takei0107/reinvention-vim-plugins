function! statusline#output() abort
  return s:build_output()
endfunction

function! s:build_output() abort
  let line = []
  for module in s:aggregate_modules()
    if !empty(module)
      call add(line, s:buile_module_output(module))
    endif
  endfor
  return s:create_statusline(line)
endfunction

function! s:create_statusline(line) abort
  return join(a:line, ' ')
endfunction

function! s:buile_module_output(module) abort
  " TODO デフォルト強調グループの決定を考慮する
  let layout_group = get(a:module, 'layout_group', 'statusline')
  let moduler = get(a:module, 'moduler', 'undefined')
  return '%#' . layout_group . '#' . statusline#modules#call_moduler_func(moduler)
endfunction

" TODO 利用するモジュールの決定
let s:target_modules = ['current_mode', 'cursol_num', 'file_position_percent']

function! s:aggregate_modules() abort
  let modules = []
  for module_name in s:target_modules
    let module = get(statusline#modules#get_modules(), module_name, {})
    if !empty(module)
      call add(modules, module)
    endif
  endfor
  return modules
endfunctio
