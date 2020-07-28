let g:nerdfont#path#custom = get(g:, 'nerdfont#path#custom', '')
let g:nerdfont#path#disable_pattern = get(g:, 'nerdfont#path#disable_pattern', v:false)
let g:nerdfont#path#disable_basename = get(g:, 'nerdfont#path#disable_basename', v:false)
let g:nerdfont#path#disable_extension = get(g:, 'nerdfont#path#disable_extension', v:false)

function! nerdfont#path#find(path, ...) abort
  let options = extend({
        \ 'disable_pattern': g:nerdfont#path#disable_pattern,
        \ 'disable_basename': g:nerdfont#path#disable_basename,
        \ 'disable_extension': g:nerdfont#path#disable_extension,
        \}, a:0 ? a:1 : {},
        \)
  if !options.disable_pattern
    let glyph = nerdfont#path#pattern#find(a:path)
    if glyph !=# ''
      return glyph
    endif
  endif
  if !options.disable_basename
    let glyph = nerdfont#path#basename#find(a:path)
    if glyph !=# ''
      return glyph
    endif
  endif
  if !options.disable_extension
    let glyph = nerdfont#path#extension#find(a:path)
    if glyph !=# ''
      return glyph
    endif
  endif
  return g:nerdfont#path#custom
endfunction
