scriptencoding utf-8

let g:nerdfont#path#pattern#customs = get(g:, 'nerdfont#path#pattern#customs', {})
let g:nerdfont#path#pattern#defaults = {
      \ '.*angular.*\.js$'      : '',
      \ '.*backbone.*\.js$'     : '',
      \ '.*jquery.*\.js$'       : '',
      \ '.*materialize.*\.css$' : '',
      \ '.*materialize.*\.js$'  : '',
      \ '.*mootools.*\.js$'     : '',
      \ '.*require.*\.js$'      : '',
      \ '.*vimrc.*'             : '',
      \ 'Vagrantfile$'          : '',
      \}

function! nerdfont#path#pattern#find(path) abort
  for [k, v] in s:m
    if a:path =~# k
      return v
    endif
  endfor
  return ''
endfunction

function! nerdfont#path#pattern#refresh() abort
  let s:m = items(extend(
        \ copy(g:nerdfont#path#pattern#defaults),
        \ g:nerdfont#path#pattern#customs,
        \))
endfunction

call nerdfont#path#pattern#refresh()
