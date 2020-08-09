" abbott.vim <https://github.com/bcat/abbott.vim>
"
" Copyright 2011-2013, 2015, 2017, 2020 Jonathan Rascher
"
" Permission to use, copy, modify, and/or distribute this software for any
" purpose with or without fee is hereby granted, provided that the above
" copyright notice and this permission notice appear in all copies.
"
" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
" REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
" AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
" INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
" LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
" OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
" PERFORMANCE OF THIS SOFTWARE.

" We define 16 main colors that map reasonably well onto the standard 16-color
" terminal palette. Indeed, these RGB colors can be assigned as the terminal
" color scheme to quite a nice effect. Two colors are nonstandard (burnt orange
" as "bright red" and mint green as "cyan"), but these selections still leave
" ample contrast in the usual console applications.

" Terminal black (0), bright black (8):
let s:brown = {'rgb': '#1f1912', 'color256': '', 'color16': '0'}
let s:light_brown = {'rgb': '#816749', 'color256': '', 'color16': '8'}

" Terminal red (1), bright red (9):
let s:red = {'rgb': '#d80450', 'color256': '', 'color16': '1'}
let s:burnt_orange = {'rgb': '#f63f05', 'color256': '', 'color16': '9'}

" Terminal green (2), bright green (10):
let s:forest_green = {'rgb': '#24a507', 'color256': '', 'color16': '2'}
let s:green = {'rgb': '#a0ea00', 'color256': '', 'color16': '10'}

" Terminal yellow (3), bright yellow (11):
let s:orange = {'rgb': '#fbb32f', 'color256': '', 'color16': '3'}
let s:yellow = {'rgb': '#fbec5d', 'color256': '', 'color16': '11'}

" Terminal blue (4), bright blue (12):
let s:blue = {'rgb': '#3f91f1', 'color256': '', 'color16': '4'}
let s:pastel_blue = {'rgb': '#8ccdf0', 'color256': '', 'color16': '12'}

" Terminal magenta (5), bright magenta (13):
let s:pink = {'rgb': '#ec6c99', 'color256': '', 'color16': '5'}
let s:lavender = {'rgb': '#e6a2f3', 'color256': '', 'color16': '13'}

" Terminal cyan (6), bright cyan (14):
let s:mint_green = {'rgb': '#d8ff84', 'color256': '', 'color16': '6'}
let s:teal = {'rgb': '#59eea5', 'color256': '', 'color16': '14'}

" Terminal white (7), bright white (15):
let s:pastel_green = {'rgb': '#c0f396', 'color256': '', 'color16': '7'}
let s:tan = {'rgb': '#fef3b4', 'color256': '', 'color16': '15'}

" We also define one additional color: black. In a 16-color terminal, this will
" be mapped to the same color as brown, but in practice this only matters for
" CursorLine and CursorColumn, and they're still identifiable via bold.

let s:black = {'rgb': '#000000', 'color256': '', 'color16': '0'}

" This color scheme refrains from using some features that cause rendering bugs
" in some terminals. These features can be enabled in case the user knows their
" terminal is well behaved.

" The g:abbott_term_use_italic option enables the use of italics in the
" terminal. This is disabled by default since the default terminfo for GNU
" Screen renders italics as reverse video, and since other terminals like hterm
" may show artifacts when rendering italics.
if !exists('g:abbott_term_use_italics')
  let g:abbott_term_use_italics = 0
endif

" The g:abbott_term_use_undercurl option enables the use of undercurl in the
" terminal. By default, underlined text will be used instead, because some
" terminfo entries cause Vim to think the terminal supports undercurl when it
" really does not (https://github.com/vim/vim/issues/3471).
if !exists('g:abbott_term_use_undercurl')
  let g:abbott_term_use_undercurl = 0
endif

" The g:abbott_term_set_undercurl_color option attempts to set the undercurl
" color separately from the text color. This prevents spell checking from
" interfering with normal syntax highlighting. By default, the foreground text
" color will be replaced by the undercurl color in the terminal since otherwise
" that color will not be visible at all.
if !exists('g:abbott_term_set_undercurl_color')
  let g:abbott_term_set_undercurl_color = 0
endif

" Returns whether Vim supports the ctermul highlight parameter.
function! s:CanSetUndercurlColor()
  return has('patch-8.2.863')
endfunction

" Highlights {group} according to the configuration given in {style}. The style
" dictionary may have color constant values with keys 'fg', 'bg', and 'sp' to
" set the highlight group's foreground, background, and undercurl colors,
" respectively. Additionally, the 'attrs' key, if present, should map to a list
" of terminal attributes.
function! s:H(group, style)
  " Evaluate terminal/GUI attributes for the highlight, possibly filtering or
  " replacing attributes the user may not wish to use in their terminal.
  let l:attrs = has_key(a:style, 'attrs') ? a:style.attrs : []
  let l:term_attrs = copy(l:attrs)

  if !g:abbott_term_use_italics
    call filter(l:term_attrs, 'v:val !=# "italic"')
  endif

  if !g:abbott_term_use_undercurl
    call map(l:term_attrs, 'v:val ==# "undercurl" ? "underline" : v:val')
  endif

  " Set up terminal foreground and undercurl colors. If the current version of
  " Vim can't set undercurl color in the terminal or if the user does not wish
  " us to use that option (e.g., because their terminal doesn't support it),
  " then we *replace* the foreground color with the undercurl ("special") color.
  if has_key(a:style, 'sp')
    if s:CanSetUndercurlColor() && g:abbott_term_set_undercurl_color
      let l:term_sp = a:style.sp
    else
      let l:term_fg = a:style.sp
    endif
  endif

  if has_key(a:style, 'fg') && !exists('l:term_fg')
    let l:term_fg = a:style.fg
  endif

  " Set the highlight. We explicitly set missing parameters to 'NONE' because
  " otherwise defaults can conflict with things we explicitly set (such as the
  " default background on SpellBad vs. our custom foreground for that group).
  execute 'highlight' a:group 'term=NONE'
      \ 'ctermfg=' (exists('l:term_fg') ? l:term_fg.color16 : 'NONE')
      \ 'ctermbg=' . (has_key(a:style, 'bg') ? a:style.bg.color16 : 'NONE')
      \ (s:CanSetUndercurlColor() ?
          \ 'ctermul=' . (exists(l:term_sp) ? l:term_sp.color16 : 'NONE')
          \ : '')
      \ 'cterm=' . (!empty(l:term_attrs) ? join(l:term_attrs, ',') : 'NONE')
      \ 'guifg=' . (has_key(a:style, 'fg') ? a:style.fg.rgb : 'NONE')
      \ 'guibg=' . (has_key(a:style, 'bg') ? a:style.bg.rgb : 'NONE')
      \ 'guisp=' . (has_key(a:style, 'sp') ? a:style.sp.rgb : 'NONE')
      \ 'gui=' . (!empty(l:attrs) ? join(l:attrs, ',') : 'NONE')
endfunction

" Mark abbott.vim as a dark theme.
set background=dark

" Reset existing syntax highlights to their default settings.
highlight clear
if exists('g:syntax_on')
  syntax reset
endif

" Declare the name of this color scheme.
let g:colors_name = 'abbott'

" Set default foreground and background colors.
call s:H('Normal', {'fg': s:pastel_green, 'bg': s:brown})

" Set up highlights for basic syntax groups.
call s:H('Comment', {'fg': s:orange, 'attrs': ['italic']})
call s:H('Constant', {'fg': s:burnt_orange})
call s:H('String', {'fg': s:lavender})
call s:H('Character', {'fg': s:lavender})
call s:H('Identifier', {'fg': s:pastel_blue})
call s:H('Statement', {'fg': s:red, 'attrs': ['bold']})
call s:H('PreProc', {'fg': s:pink})
call s:H('Type', {'fg': s:forest_green})
call s:H('Special', {'fg': s:tan})
call s:H('Tag', {'fg': s:lavender, 'attrs': ['underline']})
call s:H('Underlined', {'fg': s:lavender, 'attrs': ['underline']})
call s:H('Ignore', {'fg': s:light_brown})
call s:H('Error', {'fg': s:brown, 'bg': s:red})
call s:H('Todo', {'fg': s:brown, 'bg': s:orange})

" Set up highlights for various UI elements.
call s:H('ErrorMsg', {'fg': s:brown, 'bg': s:red})
call s:H('FoldColumn', {'fg': s:burnt_orange})
call s:H('Folded', {'fg': s:burnt_orange})
call s:H('LineNr', {'fg': s:yellow})
call s:H('ModeMsg', {'attrs': ['bold']})
call s:H('MoreMsg', {'fg': s:blue, 'attrs': ['bold']})
call s:H('Pmenu', {'fg': s:brown, 'bg': s:light_brown})
call s:H('PmenuSel', {'fg': s:brown, 'bg': s:tan, 'attrs': ['bold']})
call s:H('PmenuSbar', {'bg': s:brown})
call s:H('PmenuThumb', {'bg': s:blue})
call s:H('Question', {'fg': s:pink, 'attrs': ['bold']})
call s:H('QuickFixLine', {'fg': s:brown, 'bg': s:tan, 'attrs': ['bold']})
call s:H('SignColumn', {'fg': s:brown, 'bg': s:mint_green})
call s:H('StatusLine', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': ['bold']})
call s:H('StatusLineNC', {'fg': s:brown, 'bg': s:mint_green})
call s:H('StatusLineTerm',
    \ {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': ['bold']})
call s:H('StatusLineTermNC', {'fg': s:brown, 'bg': s:mint_green})
call s:H('TabLine', {'fg': s:brown, 'bg': s:mint_green})
call s:H('TabLineFill', {'bg': s:mint_green})
call s:H('TabLineSel', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': ['bold']})
call s:H('Title', {'fg': s:red, 'attrs': ['bold']})
call s:H('WarningMsg', {'fg': s:brown, 'bg': s:pink})
call s:H('WildMenu', {'fg': s:brown, 'bg': s:mint_green, 'attrs': ['bold']})
call s:H('VertSplit', {'fg': s:brown, 'bg': s:mint_green})

" Use plain old reverse video for the blinking cursor.
" Use an eye-catching shade of green for the blinking cursor.
call s:H('Cursor', {'fg': s:brown, 'bg': s:green})
call s:H('CursorIM', {'fg': s:brown, 'bg': s:green})

" Darken the background of the current line and column.
call s:H('CursorLine', {'bg': s:black, 'attrs': ['bold']})
call s:H('CursorLineNr', {'bg': s:black, 'attrs': ['bold']})
call s:H('CursorColumn', {'bg': s:black, 'attrs': ['bold']})

" Darken the background of the right margin.
call s:H('ColorColumn', {'fg': s:brown, 'bg': s:tan})

" Highlight matched delimiters in a way that's clearly distinguishable from
" unmatched delimiter/statement/preprocessor highlighting.
call s:H('MatchParen', {'fg': s:brown, 'bg': s:light_brown, 'attrs': ['bold']})

" Set up highlights for imaginary '~' and '@' characters, and for special keys.
call s:H('EndOfBuffer', {'fg': s:light_brown})
call s:H('NonText', {'fg': s:teal})
call s:H('SpecialKey', {'fg': s:teal})

" Set a vibrant background for visual mode.
call s:H('Visual', {'fg': s:brown, 'bg': s:green})
call s:H('VisualNOS', {'fg': s:brown, 'bg': s:mint_green})

" Use cold highlights for incremental searching and warm highlights for final
" search results.
call s:H('IncSearch', {'fg': s:brown, 'bg': s:teal})
call s:H('Search', {'fg': s:brown, 'bg': s:tan})

" Set up spell-checking in an unobtrusive way.
call s:H('SpellBad', {'sp': s:red, 'attrs': ['undercurl']})
call s:H('SpellCap', {'sp': s:pastel_blue, 'attrs': ['undercurl']})
call s:H('SpellLocal', {'sp': s:yellow, 'attrs': ['undercurl']})
call s:H('SpellRare', {'sp': s:pink, 'attrs': ['undercurl']})

" Don't do anything special for concealed tokens.
call s:H('Conceal', {})

" Set highlights for directory listings.
call s:H('Directory', {'fg': s:pastel_blue})

" Use readable diff highlights. :)
call s:H('DiffAdd', {'fg': s:brown, 'bg': s:green, 'attrs': ['bold']})
call s:H('DiffChange', {'fg': s:brown, 'bg': s:pink})
call s:H('DiffDelete', {'fg': s:brown, 'bg': s:red})
call s:H('DiffText', {'fg': s:brown, 'bg': s:teal, 'attrs': ['bold']})

" Set up custom highlights for better-whitespace.vim.
call s:H('ExtraWhitespace', {'fg': s:brown, 'bg': s:red})

" Set up custom highlights for gitcommit.vim.
call s:H('gitcommitSummary', {'attrs': ['bold']})
highlight link gitcommitOverflow Error

" Set up custom highlights for tex.vim.
highlight link texStatement PreProc
