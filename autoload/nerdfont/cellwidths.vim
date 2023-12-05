function! nerdfont#cellwidths#fix(code_points) abort
  let l:values = map(a:code_points, {_, v -> type(v) is# v:t_list ? v : [v, v]})
  let l:list = map(l:values, {_, v -> type(v) is# v:t_list ? v + [2] : [v, v, 2]})
  let l:list = s:norm(l:list + getcellwidths())
  call setcellwidths(l:list)
endfunction

function! s:compare(lhs, rhs) abort
  return a:lhs[0] == a:rhs[0]
        \ ? a:lhs[1] == a:rhs[1]
        \   ? 0
        \   : a:lhs[1] < a:rhs[1]
        \     ? -1
        \     : 1
        \ : a:lhs[0] < a:rhs[0]
        \   ? -1
        \   : 1
endfunction

function! s:norm(ranges) abort
  call uniq(sort(a:ranges, 's:compare'), 's:compare')
  let l:oldvalues = a:ranges
  let l:newvalues = [a:ranges[0]]
  let l:oldsize = len(l:oldvalues)
  let l:newsize = len(l:newvalues)
  let l:retries = 0
  while l:oldsize != l:newsize || l:retries < 5
    for l:idx in range(len(l:oldvalues))
      let l:lhs = remove(l:newvalues, -1)
      let l:rhs = l:oldvalues[l:idx]
      call extend(l:newvalues, s:merge(l:lhs, l:rhs))
    endfor
    call uniq(sort(l:newvalues, 's:compare'), 's:compare')
    let l:oldsize = len(l:oldvalues)
    let l:newsize = len(l:newvalues)
    let l:oldvalues = l:newvalues
    let l:retries += 1
  endwhile
  return l:oldvalues
endfunction

function! s:merge(a, b) abort
  if a:a[2] != a:b[2]
    return [a:a, a:b]
  elseif a:a[0] <= a:b[0] && a:b[1] <= a:a[1]
    " a: -------------
    " b:      ------
    return [[a:a[0], a:a[1], a:a[2]]]
  elseif a:b[0] <= a:a[0] && a:a[1] <= a:b[1]
    " a:      ------
    " b: -------------
    return [[a:b[0], a:b[1], a:a[2]]]
  elseif a:a[0] <= a:b[0] && a:b[0] <= a:a[1]
    " a: --------
    " b:      ------
    return [[a:a[0], max([a:a[1], a:b[1]]), a:a[2]]]
  elseif a:b[0] <= a:a[0] && a:a[0] <= a:b[1]
    " a:      ------
    " b: --------
    return [[a:b[0], max([a:a[1], a:b[1]]), a:a[2]]]
  endif
  return [a:a, a:b]
endfunction
