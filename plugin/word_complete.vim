" file word_complete.vim
" author:  Benji Fisher
" version:  0.3
" Last modified: Wed Jan 12, 2000 10:14:52 Eastern Standard Time

if has("menu")
  amenu &Tools.&Word\ Completion :call DoWordComplete()<CR>
  amenu &Tools.&Stop\ Completion :call EndWordComplete()<CR>
endif

fun! WordComplete()
  " normal viwy`>
  " let length=strlen(@")
  let length=strlen(expand("<cword>"))
  execute "normal a\<C-P>\<Esc>"
  " normal viwy`>
  " if strlen(@")>length
  if strlen(expand("<cword>"))>length
    execute "normal viwo" . length . "l\<C-G>"
  else
    if version>505
      if strlen(getline("."))>col(".")
        normal l
        startinsert
      else
        startinsert!
      endif
    else
      execute "normal a*\<Esc>gh"
    endif "version>505
  endif
endfun

fun! DoWordComplete()
  vnoremap <Tab> <Esc>`>a
  vnoremap <Esc> d
  if has("mac")
    vnoremap  <Del>a
  else
    vnoremap <BS> <Del>a
  endif "has("mac")
  if version>505
    vnoremap <C-N> <Del>a<C-N>
    vnoremap <C-P> <Del>a<C-P><C-P>
    vnoremap <C-X> <Del>a<C-P><C-X>
  endif "version>505
  inoremap a a<Esc>:call WordComplete()<CR>
  inoremap b b<Esc>:call WordComplete()<CR>
  inoremap c c<Esc>:call WordComplete()<CR>
  inoremap d d<Esc>:call WordComplete()<CR>
  inoremap e e<Esc>:call WordComplete()<CR>
  inoremap f f<Esc>:call WordComplete()<CR>
  inoremap g g<Esc>:call WordComplete()<CR>
  inoremap h h<Esc>:call WordComplete()<CR>
  inoremap i i<Esc>:call WordComplete()<CR>
  inoremap j j<Esc>:call WordComplete()<CR>
  inoremap k k<Esc>:call WordComplete()<CR>
  inoremap l l<Esc>:call WordComplete()<CR>
  inoremap m m<Esc>:call WordComplete()<CR>
  inoremap n n<Esc>:call WordComplete()<CR>
  inoremap o o<Esc>:call WordComplete()<CR>
  inoremap p p<Esc>:call WordComplete()<CR>
  inoremap q q<Esc>:call WordComplete()<CR>
  inoremap r r<Esc>:call WordComplete()<CR>
  inoremap s s<Esc>:call WordComplete()<CR>
  inoremap t t<Esc>:call WordComplete()<CR>
  inoremap u u<Esc>:call WordComplete()<CR>
  inoremap v v<Esc>:call WordComplete()<CR>
  inoremap w w<Esc>:call WordComplete()<CR>
  inoremap x x<Esc>:call WordComplete()<CR>
  inoremap y y<Esc>:call WordComplete()<CR>
  inoremap z z<Esc>:call WordComplete()<CR>
endfun

fun! EndWordComplete()
  vunmap <Tab>
  vunmap <Esc>
  if has("mac")
    vunmap 
  else
    vunmap <BS>
  endif "has("mac")
  if version>505
    vunmap <C-N>
    vunmap <C-P>
    vunmap <C-X>
  endif "version>505
  iunmap a
  iunmap b
  iunmap c
  iunmap d
  iunmap e
  iunmap f
  iunmap g
  iunmap h
  iunmap i
  iunmap j
  iunmap k
  iunmap l
  iunmap m
  iunmap n
  iunmap o
  iunmap p
  iunmap q
  iunmap r
  iunmap s
  iunmap t
  iunmap u
  iunmap v
  iunmap w
  iunmap x
  iunmap y
  iunmap z
endfun
