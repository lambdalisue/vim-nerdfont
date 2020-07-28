function! nerdfont#find(...) abort
  let path = a:0 > 0 ? a:1 : bufname('%')
  let isdir = a:0 > 1 ? a:2 : 'auto'
  let isdir = isdir ==# 'auto' ? isdirectory(path) : isdir
  if isdir
    return nerdfont#directory#find()
  else
    return nerdfont#path#find(path)
  endif
endfunction
