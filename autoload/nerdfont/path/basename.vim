let g:nerdfont#path#basename#customs = get(g:, 'nerdfont#path#basename#customs', {})
let g:nerdfont#path#basename#defaults = {
      \ 'exact-match-case-sensitive-1.txt' : '1',
      \ 'exact-match-case-sensitive-2'     : '2',
      \ 'gruntfile.coffee'                 : '',
      \ 'gruntfile.js'                     : '',
      \ 'gruntfile.ls'                     : '',
      \ 'gulpfile.coffee'                  : '',
      \ 'gulpfile.js'                      : '',
      \ 'gulpfile.ls'                      : '',
      \ 'mix.lock'                         : '',
      \ 'dropbox'                          : '',
      \ '.ds_store'                        : '',
      \ '.gitconfig'                       : '',
      \ '.gitignore'                       : '',
      \ '.gitlab-ci.yml'                   : '',
      \ '.bashrc'                          : '',
      \ '.zshrc'                           : '',
      \ '.vimrc'                           : '',
      \ '.gvimrc'                          : '',
      \ '_vimrc'                           : '',
      \ '_gvimrc'                          : '',
      \ '.bashprofile'                     : '',
      \ 'favicon.ico'                      : '',
      \ 'license'                          : '',
      \ 'node_modules'                     : '',
      \ 'react.jsx'                        : '',
      \ 'procfile'                         : '',
      \ 'dockerfile'                       : '',
      \ 'docker-compose.yml'               : '',
      \ 'rakefile'                         : '',
      \ 'config.ru'                        : '',
      \ 'gemfile'                          : '',
      \ 'makefile'                         : '',
      \ 'cmakelists.txt'                   : '',
      \}

function! nerdfont#path#basename#find(path) abort
  let n = fnamemodify(a:path, ':t')
  return get(s:m, n, '')
endfunction

function! nerdfont#path#basename#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#path#basename#defaults),
        \ g:nerdfont#path#basename#customs,
        \)
endfunction

call nerdfont#path#basename#refresh()
