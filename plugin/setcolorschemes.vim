" Change the color scheme from a list of color scheme names.
" Optionally changes the corresponding Airline theme.
" Press key:
"   F7          previous scheme
"   F8          next scheme
"   F9          random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColorSchemes all                     (all $VIMRUNTIME/colors/*.vim)
"   :SetColorSchemes my                      (names built into script)
"   :SetColorSchemes asciiville everforest   (these schemes)
"   :SetColorSchemes                         (display current scheme names)
" Set the current color scheme based on time of day:
"   :SetColorSchemes now
if v:version < 700 || exists('loaded_setcolorschemes') || &cp
  finish
endif

let loaded_setcolorschemes = 1
if exists('g:setairlinetheme')
  let s:setairlinetheme = g:setairlinetheme
else
  let s:setairlinetheme = 0
endif
if exists('g:mycolorschemes')
  let s:mycolorschemes = g:mycolorschemes
else
  let s:mycolorschemes = ['asciiville', 'everforest', 'cool', 'desertink', 'distinguished', 'hybrid', 'luna', 'molokai', 'solarized', 'zenburn']
endif

" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColorSchemes(args)
  if len(a:args) == 0
    echo 'Current color scheme names:'
    let i = 0
    while i < len(s:mycolorschemes)
      echo '  '.join(map(s:mycolorschemes[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolorschemes = map(paths, 'fnamemodify(v:val, ":t:r")')
    echo 'List of colors set from all installed color schemes'
  elseif a:args == 'my'
    let c1 = 'asciiville everforest cool'
    let c2 = 'desertink distinguished hybrid luna'
    let c3 = 'molokai solarized zenburn'
    let s:mycolorschemes = split(c1.' '.c2.' '.c3)
    echo 'List of colors set from built-in names'
  elseif a:args == 'now'
    call s:HourColor()
  else
    let s:mycolorschemes = split(a:args)
    echo 'List of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* SetColorSchemes call s:SetColorSchemes('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolorschemes) == 0
    call s:SetColorSchemes('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolorschemes, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolorschemes))
    if how == 0
      let current = localtime() % len(s:mycolorschemes)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolorschemes))
        let current = (how>0 ? 0 : len(s:mycolorschemes)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolorschemes[current]
      if s:setairlinetheme
        execute 'AirlineTheme '.s:mycolorschemes[current]
      endif
      break
    catch /E185:/
      call add(missing, s:mycolorschemes[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <F7> :call NextColor(-1)<CR>
nnoremap <F8> :call NextColor(1)<CR>
nnoremap <F9> :call NextColor(0)<CR>

" Set color scheme according to current time of day.
function! s:HourColor()
  let hr = str2nr(strftime('%H'))
  if hr <= 3
    let i = 0
  elseif hr <= 7
    let i = 1
  elseif hr <= 14
    let i = 2
  elseif hr <= 18
    let i = 3
  else
    let i = 4
  endif
  let nowcolors = 'asciiville everforest cool desertink solarized'
  execute 'colorscheme '.split(nowcolors)[i]
  if s:setairlinetheme
    execute 'AirlineTheme '.split(nowcolors)[i]
  endif
  redraw
  echo g:colors_name
endfunction

