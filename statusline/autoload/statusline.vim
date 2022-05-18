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

" NOTE ユーザー定義の関数はグローバルで良い
function! Hoge() abort
  return "hoge"
endfunction

function! s:aggregate_modules_by_position() abort
  let builtin_modules = statusline#modules#get_buitin_modules()
  " TODO target_modulesの利用しないようにする
  let target_modules_by_position = {
    \  'left'  : s:get_target_modules_by_position(s:target_modules, 'left'),
    \  'right' : s:get_target_modules_by_position(s:target_modules, 'right'),
    \}
  let merged_modules = s:get_merged_modules(get(s:target_modules, 'modules_def', {}), builtin_modules)
  let modules = {}
  for position in keys(target_modules_by_position)
    let modules_by_position = []
    let target_modules = get(target_modules_by_position, position, [])
    for module_name in target_modules
      let module = get(merged_modules, module_name, {})
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

function! s:get_merged_modules(source_modules, dest_modules) abort
  " TODO dest_modules,source_modulesのコピー作ってそれを利用するようにする
  let merged = deepcopy(a:dest_modules)
  if empty(merged)
    return merged
  endif
  for [module_name, module_def] in items(a:source_modules)
    if empty(module_def)
      continue
    endif
    let module_properties = s:create_module_properties(module_def)
    let custome_module = {}
    call statusline#utils#add_propertis_if_not_exists(custome_module, module_properties, v:true)
    call statusline#utils#add_propertis_if_not_exists(merged, {module_name : custome_module}, v:true)
  endfor
  return merged
endfunction

function! s:create_module_properties(module_def) abort
  let moduler = get(a:module_def, 'moduler')
  let layout_group = get(a:module_def, 'layout_group')
  let layout_func = get(a:module_def, 'layout_func')
  return {
    \ 'moduler' : moduler,
    \ 'layout_group' : layout_group,
    \ 'layout_func' : layout_func,
    \ }
endfunction
