scriptencoding utf-8

let g:nerdfont#directory#customs = get(g:, 'nerdfont#directory#customs', {})
let g:nerdfont#directory#defaults = {
      \ '': '',
      \ 'open': '',
      \ 'close': '',
      \ 'symlink': '',
      \}

function! nerdfont#directory#find(...) abort
  let n = a:0 ? a:1 : ''
  return get(s:m, n, '')
endfunction

function! nerdfont#directory#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#directory#defaults),
        \ g:nerdfont#directory#customs,
        \)
endfunction

call nerdfont#directory#refresh()
