" file word_complete.vim
" author:  Benji Fisher
" version:  0.4
" Last modified: Mon 31 Mar 2003 01:48:23 PM EST
" 
" DESCRIPTION:
"  Each time you type an alphabetic character, the script attempts 
"  to complete the current word.  The suggested completion is selected 
"  in Select mode, so you can just type another character to keep going. 
"  Other options:  <Tab> to accept, <BS> to get rid of the completion, 
"  <Esc> to leave Insert mode without accepting the completion, <C-N> 
"  or <C-P> to cycle through choices, <C-X> to enter <C-X> mode. 
"
"  The script works by :imap'ping each alphabetic character, and uses
"  Insert-mode completion (:help i_ctrl-p).  It is far from perfect.  For
"  example, every second character you type is in Select mode, so completions
"  are offered only half the time.  Since Select mode uses the same mappings
"  as Visual mode, the special keys mentioned above may conflict with what you
"  are used to in Visual mode.
"
"  INSTALLATION
"  :source it from your vimrc file or drop it in your plugin directory. 
"  To activate, choose "Word Completion" from the Tools menu, or type 
"  :call DoWordComplete() 
"  To make it stop, choose "Tools/Stop Completion", or type 
"  :call EndWordComplete()
"  If you want to activate the script by default, either :source it from, and
"  add the :call line above to, your vimrc file or (if you use it as a plugin,
"  in which case the functions are not defined when your vimrc file is read)
"  add the line
"  	autocmd VimEnter * call DoWordComplete()
"  to your vimrc file.

" Use Vim defaults while :source'ing this file.
let save_cpo = &cpo
set cpo&vim

if has("menu")
  amenu &Tools.&Word\ Completion :call DoWordComplete()<CR>
  amenu &Tools.&Stop\ Completion :call EndWordComplete()<CR>
endif

" Return the :lmap value if there is one, otherwise echo the input.
fun! s:Langmap(char)
  let val = maparg(a:char, "l")
  return (val != "") ? val : a:char
endfun

fun! WordComplete()
  " Save and reset the 'ignorecase' option.
  let save_ic = &ignorecase
  set noignorecase
  let length=strlen(expand("<cword>"))
  " Use language maps (keymaps) if appropriate.
  if &iminsert == 1
    let char = getline(".")[col(".")-1]
    let lchar = maparg(char, "l")
    if lchar != ""
      execute "normal! r" . lchar
    endif
  endif
  if strlen(getline(".")) == col(".")
	\ || getline(".")[col(".")] =~ '[[:punct:][:space:]]'
    execute "normal a\<C-P>\<Esc>"
  endif
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
  " Restore the 'ignorecase' option.
  let &ignorecase = save_ic
endfun

" Make an :imap for each alphabetic character, and define a few :vmap's.
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
  " Thanks to Bohdan Vlasyuk for suggesting a loop here:
  let letter = "a"
  while letter <= "z"
    execute "inoremap" letter letter . "<Esc>:call WordComplete()<CR>"
    let letter = nr2char(char2nr(letter) + 1)
  endwhile
endfun

" Remove all the mappings created by DoWordComplete().
" Lazy:  I do not save and restore existing mappings.
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
  " Thanks to Bohdan Vlasyuk for suggesting a loop here:
  let letter = char2nr("a")
  while letter <= char2nr("z")
    execute "iunmap" nr2char(letter)
    let letter = letter + 1
  endwhile
endfun

let &cpo = save_cpo
