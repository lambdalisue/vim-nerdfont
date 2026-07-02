scriptencoding utf-8

let g:nerdfont#filetype#customs = get(g:, 'nerdfont#filetype#customs', {})
let g:nerdfont#filetype#defaults = {
      \ 'awk'             : '',
      \ 'c'               : '',
      \ 'clojure'         : '',
      \ 'cmake'           : '',
      \ 'cpp'             : '',
      \ 'cs'              : '',
      \ 'csh'             : '',
      \ 'css'             : '',
      \ 'd'               : '',
      \ 'dart'            : '',
      \ 'diff'            : '',
      \ 'dockerfile'      : '',
      \ 'dosbatch'        : '',
      \ 'dosini'          : '',
      \ 'elm'             : '',
      \ 'erlang'          : '',
      \ 'euphoria3'       : '',
      \ 'forth'           : '',
      \ 'gitconfig'       : '',
      \ 'go'              : '',
      \ 'haml'            : '',
      \ 'haskell'         : '',
      \ 'html'            : '',
      \ 'java'            : '',
      \ 'javascript'      : '',
      \ 'javascriptreact' : '',
      \ 'json'            : '',
      \ 'less'            : '',
      \ 'lhaskell'        : '',
      \ 'lua'             : '',
      \ 'make'            : '',
      \ 'markdown'        : '',
      \ 'ocaml'           : 'λ',
      \ 'pascal'          : '',
      \ 'perl'            : '',
      \ 'php'             : '',
      \ 'plaintex'        : 'ﭨ',
      \ 'postscr'         : '',
      \ 'python'          : '',
      \ 'r'               : 'ﳒ',
      \ 'rmd'             : '',
      \ 'ruby'            : '',
      \ 'rust'            : '',
      \ 'sass'            : '',
      \ 'scala'           : '',
      \ 'scss'            : '',
      \ 'sh'              : '',
      \ 'sql'             : '',
      \ 'swift'           : '',
      \ 'tads'            : '',
      \ 'twig'            : '',
      \ 'typescript'      : '',
      \ 'typescriptreact' : '',
      \ 'vim'             : '',
      \ 'vue'             : '﵂',
      \ 'xml'             : '',
      \ 'yaml'            : '',
      \ 'zsh'             : '',
      \}

function! nerdfont#filetype#find(...) abort
  let n = a:0 ? a:1 : &filetype
  return get(s:m, n, '')
endfunction

function! nerdfont#filetype#refresh() abort
  let s:m = extend(
        \ copy(g:nerdfont#filetype#defaults),
        \ g:nerdfont#filetype#customs,
        \)
endfunction

call nerdfont#filetype#refresh()
