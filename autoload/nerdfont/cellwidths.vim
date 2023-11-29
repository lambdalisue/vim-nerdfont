" https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points#overview
" Codicons                ea60 - ebeb
" Devicons                e700 - e7c5
" Font Awesome            f000 - f2e0
" Font Awesome Extension  e200 - e2a9
" Font Logos              f300 - f372
" IEC Power Symbols       23fb - 23fe
" IEC Power Symbols       2b58
" Material Design         f0001-f1af0
" Material Design         f500 - fd46
" Octicons                2665
" Octicons                26a1
" Octicons                f400 - f532
" Pomicons                e000 - e00a
" Powerline               e0a0 - e0a2
" Powerline               e0b0 - e0b3
" Powerline Extra         e0a3
" Powerline Extra         e0b4 - e0c8
" Powerline Extra         e0ca
" Powerline Extra         e0cc - e0d4
" Seti-UI + Custom        e5fa - e6b1
" Weather Icons           e300 - e3e3
const g:nerdfont#cellwidths#code_points = {
      \ 'Codicons': [[0xea60, 0xebeb]],
      \ 'Devicons': [[0xe700, 0xe7c5]],
      \ 'Font Awesome': [[0xf000, 0xf2e0]],
      \ 'Font Awesome Extension': [[0xe200, 0xe2a9]],
      \ 'Font Logos': [[0xf300, 0xf372]],
      \ 'IEC Power Symbols': [[0x23fb, 0x23fe], 0x2b58],
      \ 'Material Design': [[0xf0001, 0xf1af0], [0xf500, 0xfd46]],
      \ 'Octicons': [0x2665, 0x26a1, [0xf400, 0xf532]],
      \ 'Pomicons': [[0xe000, 0xe00a]],
      \ 'Powerline': [[0xe0a0, 0xe0a2], [0xe0b0, 0xe0b3]],
      \ 'Powerline Extra': [0xe0a3, [0xe0b4, 0xe0c8], 0xe0ca, [0xe0cc, 0xe0d4]],
      \ 'Seti-UI + Custom': [[0xe5fa, 0xe6b1]],
      \ 'Weather Icons': [[0xe300, 0xe3e3]],
      \}

function! nerdfont#cellwidths#fix() abort
  let l:values = reduce(values(g:nerdfont#cellwidths#code_points), { a, v -> a + v })
  let l:values = map(l:values, {_, v -> type(v) is# v:t_list ? v : [v, v]})
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
