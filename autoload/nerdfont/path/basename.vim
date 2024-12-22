let g:nerdfont#path#basename#customs = get(g:, 'nerdfont#path#basename#customs', {})
let g:nerdfont#path#basename#defaults = extend(nerdfont#get_json('basename'), nerdfont#get_json('extra/basename'))

function! nerdfont#path#basename#find(path) abort
  let n = tolower(fnamemodify(a:path, ':t'))
  return get(s:m, n, '')
endfunction

function! nerdfont#path#basename#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#path#basename#defaults),
        \ g:nerdfont#path#basename#customs,
        \)
endfunction

call nerdfont#path#basename#refresh()
