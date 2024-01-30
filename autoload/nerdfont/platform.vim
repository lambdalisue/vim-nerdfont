let g:nerdfont#platform#customs = get(g:, 'nerdfont#platform#customs', {})
let g:nerdfont#platform#defaults = nerdfont#get_json('platform')

function! nerdfont#platform#find(...) abort
  let n = a:0 ? a:1 : s:find_platform()
  return get(s:m, n, '')
endfunction

function! s:find_platform() abort
  if exists('s:platform')
    return s:platform
  endif
  if has('win32')
    let s:platform = 'windows'
    return s:platform
  endif
  if has('mac') || has('macunix')
    let s:platform = 'macos'
    return s:platform
  endif
  " https://wiki.termux.com/wiki/Differences_from_Linux
  if $PREFIX ==# '/data/data/com.termux/files/usr'
    let s:platform = 'android'
    return s:platform
  endif
  let s:platform = s:find_distro()
  return s:platform
endfunction

function! s:find_distro() abort
  if executable('lsb_release')
    let result = system('lsb_release -i')
    if result =~# 'Arch'
      return 'arch'
    elseif result =~# 'NixOS'
      return 'nixos'
    elseif result =~# 'Gentoo'
      return 'gentoo'
    elseif result =~# 'Ubuntu'
      return 'ubuntu'
    elseif result =~# 'Cent'
      return 'centos'
    elseif result =~# 'Debian'
      return 'debian'
    elseif result =~# 'Dock'
      return 'docker'
    endif
  endif
  return 'linux'
endfunction

function! nerdfont#platform#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#platform#defaults),
        \ g:nerdfont#platform#customs,
        \)
endfunction

call nerdfont#platform#refresh()
