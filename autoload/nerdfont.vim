let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let s:json_dir = s:path . '/assets/json'

function! nerdfont#get_json(json_name) abort
  let l:json = s:json_dir . '/' . a:json_name . '.json'
  let l:result = json_decode(join(readfile(l:json), ''))
  call s:autofix(l:result)
  return l:result
endfunction

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

function! s:autofix(result) abort
  if exists('*setcellwidths') && get(g:, 'nerdfont#autofix_cellwidths', 0)
    try
      let l:code_points = map(values(a:result), {_, v -> char2nr(v)})
      let l:code_points = filter(l:code_points, {_, v -> v > 0x80})
      call nerdfont#cellwidths#fix(l:code_points)
    catch
      echohl WarningMsg
      echo '[nerdfont]: Failed to fix cellwidths of nerd font glyphs.'
      echo '[nerdfont]: Disable this autofix feature by setting `g:nerdfont#autofix_cellwidths` to 0.'
      echohl None
      let g:nerdfont#autofix_cellwidths = 0
    endtry
  endif
endfunction

let g:nerdfont#default = get(g:, 'nerdfont#default',
      \ g:nerdfont#path#extension#defaults['.'])

