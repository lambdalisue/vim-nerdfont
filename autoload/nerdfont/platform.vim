let g:nerdfont#platform#customs = get(g:, 'nerdfont#platform#customs', {})
let g:nerdfont#platform#defaults = nerdfont#get_json('platform')

function! nerdfont#platform#find(...) abort
  let n = a:0 ? a:1 : s:find_platform()
  return get(s:m, n, '')
endfunction

""
" https://github.com/romkatv/powerlevel10k/blob/master/internal/wizard.zsh
" refer `os_icon_name()`
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
  if has('sun')
    let s:platform = 'sunos'
    return s:platform
  endif
  if has('bsd')
    let s:platform = 'freebsd'
    return s:platform
  endif
  " https://wiki.termux.com/wiki/Differences_from_Linux
  if $PREFIX ==# '/data/data/com.termux/files/usr'
    let s:platform = 'android'
    return s:platform
  endif
  if filereadable('/etc/artix-release')
    let s:platform = 'artix'
    return s:platform
  endif
  let s:platform = s:find_distro()
  return s:platform
endfunction

function! s:find_distro() abort
  let filename = '/etc/os-release'
  if !filereadable(filename)
    let filename = '/usr/lib/os-release'
  endif
  if filereadable(filename)
    let result = ''
    for line in readfile(filename)
      if line =~# '^ID='
        let result = substitute(line, '^ID=', '', '')
        break
      endif
    endfor
    if result =~# 'arch'
      return 'arch'
    elseif result =~# 'debian'
      return 'debian'
    elseif result =~# 'raspbian'
      return 'raspbian'
    elseif result =~# 'ubuntu'
      return 'ubuntu'
    elseif result =~# 'elementary'
      return 'elementary'
    elseif result =~# 'fedora'
      return 'fedora'
    elseif result =~# 'coreos'
      return 'coreos'
    elseif result =~# 'kali'
      return 'kali'
    elseif result =~# 'gentoo'
      return 'gentoo'
    elseif result =~# 'mageia'
      return 'mageia'
    elseif result =~# 'centos'
      return 'centos'
    elseif result =~# 'opensuse'
      return 'opensuse'
    elseif result =~# 'tumbleweed'
      return 'opensuse'
    elseif result =~# 'sabayon'
      return 'sabayon'
    elseif result =~# 'slackware'
      return 'slackware'
    elseif result =~# 'linuxmint'
      return 'mint'
    elseif result =~# 'alpine'
      return 'alpine'
    elseif result =~# 'aosc'
      return 'aosc'
    elseif result =~# 'nixos'
      return 'nixos'
    elseif result =~# 'devuan'
      return 'devuan'
    elseif result =~# 'manjaro'
      return 'manjaro'
    elseif result =~# 'void'
      return 'void'
    elseif result =~# 'artix'
      return 'artix'
    elseif result =~# 'rhel'
      return 'rhel'
    elseif result =~# 'amzn'
      return 'amzn'
    elseif result =~# 'endeavouros'
      return 'endeavouros'
    elseif result =~# 'rocky'
      return 'rocky'
    elseif result =~# 'guix'
      return 'guix'
    elseif result =~# 'dock'
      return 'docker'
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
