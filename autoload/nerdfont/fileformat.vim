let g:nerdfont#fileformat#customs = get(g:, 'nerdfont#fileformat#customs', {})
let g:nerdfont#fileformat#defaults = nerdfont#get_json('fileformat')

function! nerdfont#fileformat#find(...) abort
  let n = a:0 ? a:1 : &fileformat
  return get(s:m, n, '')
endfunction

function! nerdfont#fileformat#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#fileformat#defaults),
        \ g:nerdfont#fileformat#customs,
        \)
endfunction

call nerdfont#fileformat#refresh()
