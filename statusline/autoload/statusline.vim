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
  \ },
  \ 'modules_override' : {
  \   'file_format' : {
  \     'layout_group' : 'wildmenu',
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

let s:cached_modules = {}
function! s:aggregate_modules_by_position() abort
  " TODO 設定が変わったときに再キャッシュする
  if !empty(s:cached_modules)
    return s:cached_modules
  endif
  let builtin_modules = statusline#modules#get_buitin_modules()
  " TODO target_modulesの利用しないようにする
  let target_modules_by_position = {
    \  'left'  : s:get_target_modules_by_position(s:target_modules, 'left'),
    \  'right' : s:get_target_modules_by_position(s:target_modules, 'right'),
    \}
  let merged_modules = s:get_merged_modules(get(s:target_modules, 'modules_def', {}), builtin_modules)
  let overrided_modules = s:get_overrided_modules(get(s:target_modules, 'modules_override', {}), merged_modules)
  let modules = {}
  for [position, target_modules] in items(target_modules_by_position)
    let modules_by_position = []
    for module_name in target_modules
      let module = get(overrided_modules, module_name, {})
      if !empty(module)
        call add(modules_by_position, module)
      endif
    endfor
    let modules[position] = modules_by_position
  endfor
  let s:cached_modules = modules
  return modules
endfunction

function! s:get_target_modules_by_position(target_modules, position) abort
  return get(a:target_modules, a:position, [])
endfunction

function! s:get_merged_modules(source_modules, dest_modules) abort
  let merged = deepcopy(a:dest_modules)
  if empty(merged)
    return merged
  endif
  for [module_name, module_def] in items(a:source_modules)
    if empty(module_def)
      continue
    endif
    let module_properties = statusline#modules#create_module_properties(module_def)
    let custome_module = {}
    call statusline#utils#add_propertis_if_not_exists(custome_module, module_properties, v:true)
    call statusline#utils#add_propertis_if_not_exists(merged, {module_name : custome_module}, v:true)
  endfor
  return merged
endfunction

function! s:get_overrided_modules(override_defs, dest_modules) abort
  let overrided = deepcopy(a:dest_modules)
  if empty(overrided)
    return overrided
  endif
  for [module_name, override_def] in items(a:override_defs)
    if has_key(overrided, module_name)
      call statusline#modules#override_module_def(get(overrided, module_name), override_def)
    endif
  endfor
  return overrided
endfunction
