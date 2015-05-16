" Vim color file
" Name: abbott.vim
" Description: An oddly named dark Vim color scheme
" Maintainer: Jonathan Rascher <jon@bcat.name>
" Version: 1.3

" Copyright © 2011-15 Jonathan Rascher.
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

" Color constants, grayscale:
let s:black = '#000000'

" Color constants, brown:
let s:tan = '#fee3b4'
let s:light_brown = '#816749'
let s:brown = '#1f1912'

" Color constants, red:
let s:pink = '#ec6c99'
let s:red = '#d80450'

" Color constants, yellow:
let s:yellow = '#e5e339'

" Color constants, orange:
let s:burnt_orange = '#f63f05'
let s:orange = '#fbb32f'

" Color constants, green:
let s:mint_green = '#bdf7a9'
let s:pastel_green = '#d8ff84'
let s:lime_green = '#94d900'
let s:green = '#76bc20'

" Color constants, blue:
let s:pastel_blue = '#8ccdf0'
let s:blue = '#3f91f1'

" Color constants, violet:
let s:lavender = '#e6a2f3'


""
" Highlights {group} according to the configuration given in {style}. The style
" dictionary may have color constant values with keys 'fg', 'bg', and 'sp' to
" set the highlight group's foreground, background, and undercurl colors,
" respectively. Additionally, the 'attrs' key, if present, should map to a
" string containing comma-separated terminal attributes.
function! s:H(group, style)
  execute 'highlight' a:group
      \ 'guifg=' . (has_key(a:style, 'fg') ? a:style.fg : 'NONE')
      \ 'guibg=' . (has_key(a:style, 'bg') ? a:style.bg : 'NONE')
      \ 'guisp=' . (has_key(a:style, 'sp') ? a:style.sp : 'NONE')
      \ 'gui=' . (has_key(a:style, 'attrs') ? a:style.attrs : 'NONE')
endfunction


" Mark abbott.vim as a dark theme.
set background=dark

" Reset existing syntax highlights to their default settings.
highlight clear
if exists('syntax_on')
  syntax reset
endif

" Declare the name of this color scheme.
let g:colors_name = 'abbott'

" Tell the CSApprox plugin not to override the default terminal background.
let g:CSApprox_hook_abbott_post = 'highlight Normal ctermbg=NONE'

" Set default foreground and background colors.
call s:H('Normal', {'fg': s:mint_green, 'bg': s:brown})

" Set up highlights for basic syntax groups.
call s:H('Comment', {'fg': s:orange})
call s:H('Constant', {'fg': s:burnt_orange})
call s:H('String', {'fg': s:lavender})
call s:H('Character', {'fg': s:lavender})
call s:H('Identifier', {'fg': s:pastel_blue})
call s:H('Statement', {'fg': s:red, 'attrs': 'bold'})
call s:H('PreProc', {'fg': s:pink})
call s:H('Type', {'fg': s:green})
call s:H('Special', {'fg': s:tan})
call s:H('Tag', {'fg': s:lavender, 'attrs': 'underline'})
call s:H('Underlined', {'fg': s:lavender, 'attrs': 'underline'})
call s:H('Ignore', {'fg': 'bg'})
call s:H('Error', {'fg': s:brown, 'bg': s:red})
call s:H('Todo', {'fg': s:brown, 'bg': s:orange})

" Set up highlights for various UI elements.
call s:H('ErrorMsg', {'fg': s:brown, 'bg': s:red})
call s:H('Folded', {'fg': s:brown, 'bg': s:pastel_blue})
call s:H('FoldColumn', {'fg': s:brown, 'bg': s:pastel_blue})
call s:H('LineNr', {'fg': s:yellow})
call s:H('ModeMsg', {'attrs': 'bold'})
call s:H('MoreMsg', {'fg': s:blue, 'attrs': 'bold'})
call s:H('Pmenu', {'fg': s:black, 'bg': s:light_brown})
call s:H('PmenuSel', {'fg': s:black, 'bg': s:tan, 'attrs': 'bold'})
call s:H('PmenuSbar', {'bg': s:black})
call s:H('PmenuThumb', {'bg': s:blue})
call s:H('Question', {'fg': s:pink, 'attrs': 'bold'})
call s:H('SignColumn', {'fg': s:brown, 'bg': s:mint_green})
call s:H('StatusLine', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': 'bold'})
call s:H('StatusLineNC', {'fg': s:brown, 'bg': s:mint_green})
call s:H('TabLine', {'fg': s:brown, 'bg': s:mint_green})
call s:H('TabLineFill', {'bg': s:mint_green})
call s:H('TabLineSel', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': 'bold'})
call s:H('Title', {'fg': s:red, 'attrs': 'bold'})
call s:H('WarningMsg', {'fg': s:brown, 'bg': s:pink})
call s:H('WildMenu', {'fg': s:brown, 'bg': s:mint_green})
call s:H('VertSplit', {'fg': s:brown, 'bg': s:mint_green})

" Use plain old reverse video for the blinking cursor.
" Use an eye-catching shade of green for the blinking cursor.
call s:H('Cursor', {'fg': s:brown, 'bg': s:green})
call s:H('CursorIM', {'fg': s:brown, 'bg': s:green})

" Darken the background of the current line and column.
call s:H('CursorLine', {'bg': s:black})
call s:H('CursorColumn', {'bg': s:black})

" Darken the background of the right margin.
call s:H('ColorColumn', {'fg': s:brown, 'bg': s:tan})

" Highlight matched delimiters in a way that's clearly distinguishable from
" unmatched delimiter/statement/preprocessor highlighting.
call s:H('MatchParen', {'fg': s:black, 'bg': s:light_brown, 'attrs': 'bold'})

" Set up highlights for imaginary '~' and '@' characters, and for special keys.
call s:H('NonText', {'fg': s:pastel_blue})
call s:H('SpecialKey', {'fg': s:pastel_blue})

" Set a vibrant background for visual mode.
call s:H('Visual', {'fg': s:brown, 'bg': s:lime_green})
call s:H('VisualNOS', {'fg': s:brown, 'bg': s:pastel_green})

" Use cold highlights for incremental searching and warm highlights for final
" search results.
call s:H('IncSearch', {'fg': s:brown, 'bg': s:pastel_blue})
call s:H('Search', {'fg': s:brown, 'bg': s:tan})

" Set up spell-checking in an unobtrusive way.
call s:H('SpellBad', {'sp': s:red, 'attrs': 'undercurl'})
call s:H('SpellCap', {'sp': s:pastel_blue, 'attrs': 'undercurl'})
call s:H('SpellLocal', {'sp': s:yellow, 'attrs': 'undercurl'})
call s:H('SpellRare', {'sp': s:pink, 'attrs': 'undercurl'})

" Don't do anything special for concealed tokens.
call s:H('Conceal', {})

" Set highlights for directory listings.
call s:H('Directory', {'fg': s:pastel_blue})

" Use readable diff highlights. :)
call s:H('DiffAdd', {'fg': s:brown, 'bg': s:green, 'attrs': 'bold'})
call s:H('DiffChange', {'fg': s:brown, 'bg': s:pink})
call s:H('DiffDelete', {'fg': s:brown, 'bg': s:red})
call s:H('DiffText', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': 'bold'})

" Set up custom highlights for bad-whitespace.vim.
call s:H('BadWhitespace', {'fg': s:brown, 'bg': s:red})

" Render TeX macros in preprocessor style. They are macros, after all. :P
highlight link texStatement PreProc
