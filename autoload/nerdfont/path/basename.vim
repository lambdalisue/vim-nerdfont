scriptencoding utf-8

let g:nerdfont#path#basename#customs = get(g:, 'nerdfont#path#basename#customs', {})
let g:nerdfont#path#basename#defaults = {
      \ '.bashprofile'                     : '',
      \ '.bashrc'                          : '',
      \ '.ds_store'                        : '',
      \ '.gitconfig'                       : '',
      \ '.gitignore'                       : '',
      \ '.gitlab-ci.yml'                   : '',
      \ '.gvimrc'                          : '',
      \ '.vimrc'                           : '',
      \ '.zshrc'                           : '',
      \ '.zprofile'                        : '',
      \ '_gvimrc'                          : '',
      \ '_vimrc'                           : '',
      \ 'cmakelists.txt'                   : '',
      \ 'requirements.txt'                 : '',
      \ 'config.ru'                        : '',
      \ 'docker-compose.yml'               : '',
      \ 'dockerfile'                       : '',
      \ 'dropbox'                          : '',
      \ 'exact-match-case-sensitive-1.txt' : '1',
      \ 'exact-match-case-sensitive-2'     : '2',
      \ 'favicon.ico'                      : '',
      \ 'gemfile'                          : '',
      \ 'gruntfile.coffee'                 : '',
      \ 'gruntfile.js'                     : '',
      \ 'gruntfile.ls'                     : '',
      \ 'gulpfile.coffee'                  : '',
      \ 'gulpfile.js'                      : '',
      \ 'gulpfile.ls'                      : '',
      \ 'license'                          : '',
      \ 'makefile'                         : '',
      \ 'mix.lock'                         : '',
      \ 'node_modules'                     : '',
      \ 'pkgbuild'                         : '',
      \ 'procfile'                         : '',
      \ 'rakefile'                         : '',
      \ 'react.jsx'                        : '',
      \}

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
