let g:nerdfont#path#extension#customs = get(g:, 'nerdfont#path#extension#customs', {})
let g:nerdfont#path#extension#defaults = extend(nerdfont#get_json('extension'), nerdfont#get_json('extra/basename'))

function! nerdfont#path#extension#find(path) abort
  let n = tolower(fnamemodify(a:path, ':e'))
  return get(s:m, n, '')
endfunction

function! nerdfont#path#extension#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#path#extension#defaults),
        \ g:nerdfont#path#extension#customs,
        \)
endfunction

call nerdfont#path#extension#refresh()
