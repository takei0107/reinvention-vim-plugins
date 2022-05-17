function! statusline#output() abort
  return s:build_output()
endfunction

function! s:build_output() abort
  let modules_by_positon = s:aggregate_modules_by_position()
  let line_by_position = {}
  for position in keys(modules_by_positon)
    let modules = get(modules_by_positon, position, [])
    let outputs = []
    for module in modules
      if !empty(module)
        let output = statusline#modules#output(module)
        call add(outputs, output)
      endif
    endfor
    let line_by_position[position] = s:create_line(outputs)
  endfor
  return s:join_line_by_position(line_by_position)
endfunction

function! s:join_line_by_position(line_by_position)
  let left_output = get(a:line_by_position, 'left', [])
  let right_output = get(a:line_by_position, 'right', [])
  return left_output . '%=' . right_output
endfunction

function! s:create_line(outputs) abort
  return join(a:outputs, ' ')
endfunction

" TODO 利用するモジュールの決定
let s:target_modules = {
  \ 'left' : ['file_encoding', 'file_format'],
  \ 'right' : ['current_mode', 'hoge'],
  \ 'modules_def' : {
  \   'hoge' : {
  \     'moduler' : "Hoge",
  \   }
  \ }
  \ }

let s:default_modules = {
  \ 'left' : ['current_mode', 'file_name'],
  \ 'right' : ['file_format', 'file_encoding', 'file_type', 'file_position_percent']
  \ }

function! Hoge() abort
  return "hoge"
endfunction

function! s:aggregate_modules_by_position() abort
  let builtin_modules = statusline#modules#get_buitin_modules()
  " TODO target_modulesの利用しないようにする
  call s:merge_modules(get(s:target_modules, 'modules_def', {}), builtin_modules)
  let target_modules_by_position = {
    \  'left'  : s:get_target_modules_by_position(s:target_modules, 'left'),
    \  'right' : s:get_target_modules_by_position(s:target_modules, 'right'),
    \}
  let modules = {}
  for position in keys(target_modules_by_position)
    let modules_by_position = []
    let target_modules = get(target_modules_by_position, position, [])
    for module_name in target_modules
      let module = get(builtin_modules, module_name, {})
      if !empty(module)
        call add(modules_by_position, module)
      endif
    endfor
    let modules[position] = modules_by_position
  endfor
  return modules
endfunction

function! s:get_target_modules_by_position(target_modules, position) abort
  return get(a:target_modules, a:position, [])
endfunction

function! s:merge_modules(source_modules, dest_modules) abort
  if empty(a:source_modules)
    return a:dest_modules
  endif
  for [module_name, module_def] in items(a:source_modules)
    if empty(module_def)
      continue
    endif
    let properties = {
      \ 'moduler' : get(module_def, 'moduler'),
      \ 'layout_group' : get(module_def, 'layout_group'),
      \ 'layout_func' : get(module_def, 'layout_func'),
      \ }
    let obj = {}
    call statusline#utils#add_propertis_if_not_exists(obj, properties, v:true)
    call statusline#utils#add_propertis_if_not_exists(a:dest_modules, {module_name : obj}, v:true)
  endfor
endfunction
