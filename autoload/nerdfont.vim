scriptencoding utf-8

function! nerdfont#find(...) abort
  let path = a:0 > 0 ? a:1 : bufname('%')
  let isdir = a:0 > 1 ? a:2 : 'auto'

  let glyph = nerdfont#path#pattern#find(path)
  if !empty(glyph)
    return glyph
  endif

  let glyph = nerdfont#path#basename#find(path)
  if !empty(glyph)
    return glyph
  endif

  let isdir = isdir ==# 'auto' ? isdirectory(path) : isdir
  if !empty(isdir)
    return nerdfont#directory#find(type(isdir) is# v:t_string ? isdir : '')
  endif

  let glyph = nerdfont#path#extension#find(path)
  if !empty(glyph)
    return glyph
  endif

  return g:nerdfont#default
endfunction

let g:nerdfont#default = get(g:, 'nerdfont#default', '')
