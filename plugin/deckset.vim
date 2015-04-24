" deckset.vim
" Author:  Dean Ashton <dean.ashton@gmail.com>
" URL:     https://github.com/deanashton/vim-deckset
" Version: 0.1.0
" License: Same as Vim itself (see :help license)

" Don't do anything if we're not on OS X.
if !has('unix') || system('uname -s') != "Darwin\n"
  finish
endif

if &cp || exists("g:deckset_loaded") && g:deckset_loaded
  finish
endif
let g:deckset_loaded = 1
let s:save_cpo = &cpo
set cpo&vim

let g:deckset_app = get(g:, "deckset_app", "Deckset")

let s:open_documents = []

function s:OpenDeckset(background)
  let l:filename = expand("%:p")

  if index(s:open_documents, l:filename) < 0
    call add(s:open_documents, l:filename)
  endif

  silent exe "!open -a '".g:deckset_app."' ".(a:background ? '-g' : '')." '".l:filename."'"
  redraw!
endfunction

function s:QuitDeckset(path)
let cmd = " -e 'try'"
let cmd .= " -e 'if application \"".g:deckset_app."\" is running then'"
let cmd .= " -e 'tell application \"".g:deckset_app."\"'"
let cmd .= " -e 'repeat with doc in documents'"
let cmd .= " -e 'if file of doc is equal to \"".a:path."\" as POSIX file then'"
let cmd .= " -e 'close doc'"
let cmd .= " -e 'end if'"
let cmd .= " -e 'end repeat'"
let cmd .= " -e 'delay 1'"
let cmd .= " -e 'if (count of documents) = 0 then'"
let cmd .= " -e 'quit'"
let cmd .= " -e 'end if'"
let cmd .= " -e 'end tell'"
let cmd .= " -e 'end if'"
let cmd .= " -e 'end try'"


  silent exe "!osascript ".cmd
  redraw!
endfunction

function s:QuitAll()
  for document in s:open_documents
    call s:QuitDeckset(document)
  endfor
endfunction

augroup deckset_commands
  autocmd!
  autocmd FileType markdown,mkd,ghmarkdown command! -buffer -bang DecksetOpen :call s:OpenDeckset(<bang>0)
  autocmd FileType markdown,mkd,ghmarkdown command! -buffer DecksetQuit :call s:QuitDeckset(expand('%:p'))
  autocmd VimLeavePre * call s:QuitAll()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:ft=vim:fdm=marker:ts=2:sw=2:sts=2:et
