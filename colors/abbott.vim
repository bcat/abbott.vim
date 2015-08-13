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

" Color constants, brown:
let s:tan = {'rgb': '#fef3b4', 'color16': '15'}
let s:light_brown = {'rgb': '#816749', 'color16': '8'}
let s:brown = {'rgb': '#1f1912', 'color16': '0'}

" Color constants, red:
let s:pink = {'rgb': '#ec6c99', 'color16': '5'}
let s:red = {'rgb': '#d80450', 'color16': '1'}

" Color constants, yellow:
let s:yellow = {'rgb': '#fbec5d', 'color16': '11'}

" Color constants, orange:
let s:burnt_orange = {'rgb': '#f63f05', 'color16': '9'}
let s:orange = {'rgb': '#fbb32f', 'color16': '3'}

" Color constants, green:
let s:mint_green = {'rgb': '#d8ff84', 'color16': '6'}
let s:pastel_green = {'rgb': '#c0f396', 'color16': '7'}
let s:green = {'rgb': '#a0ea00', 'color16': '10'}
let s:forest_green = {'rgb': '#24a507', 'color16': '2'}

" Color constants, blue:
let s:teal = {'rgb': '#59eea5', 'color16': '14'}
let s:pastel_blue = {'rgb': '#8ccdf0', 'color16': '12'}
let s:blue = {'rgb': '#3f91f1', 'color16': '4'}

" Color constants, violet:
let s:lavender = {'rgb': '#e6a2f3', 'color16': '13'}


""
" Highlights {group} according to the configuration given in {style}. The style
" dictionary may have color constant values with keys 'fg', 'bg', and 'sp' to
" set the highlight group's foreground, background, and undercurl colors,
" respectively. Additionally, the 'attrs' key, if present, should map to a
" string containing comma-separated terminal attributes.
function! s:H(group, style)
  execute 'highlight' a:group 'term=NONE'
      \ 'ctermfg=' . (has_key(a:style, 'sp') ? a:style.sp.color16
          \ : has_key(a:style, 'fg') ? a:style.fg.color16 : 'NONE')
      \ 'ctermbg=' . (has_key(a:style, 'bg') ? a:style.bg.color16 : 'NONE')
      \ 'cterm=' . (has_key(a:style, 'attrs') ? a:style.attrs : 'NONE')
      \ 'guifg=' . (has_key(a:style, 'fg') ? a:style.fg.rgb : 'NONE')
      \ 'guibg=' . (has_key(a:style, 'bg') ? a:style.bg.rgb : 'NONE')
      \ 'guisp=' . (has_key(a:style, 'sp') ? a:style.sp.rgb : 'NONE')
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

" Set default foreground and background colors.
call s:H('Normal', {'fg': s:pastel_green, 'bg': s:brown})

" Set up highlights for basic syntax groups.
call s:H('Comment', {'fg': s:orange})
call s:H('Constant', {'fg': s:burnt_orange})
call s:H('String', {'fg': s:lavender})
call s:H('Character', {'fg': s:lavender})
call s:H('Identifier', {'fg': s:pastel_blue})
call s:H('Statement', {'fg': s:red, 'attrs': 'bold'})
call s:H('PreProc', {'fg': s:pink})
call s:H('Type', {'fg': s:forest_green})
call s:H('Special', {'fg': s:tan})
call s:H('Tag', {'fg': s:lavender, 'attrs': 'underline'})
call s:H('Underlined', {'fg': s:lavender, 'attrs': 'underline'})
call s:H('Ignore', {'fg': s:light_brown})
call s:H('Error', {'fg': s:brown, 'bg': s:red})
call s:H('Todo', {'fg': s:brown, 'bg': s:orange})

" Set up highlights for various UI elements.
call s:H('ErrorMsg', {'fg': s:brown, 'bg': s:red})
call s:H('FoldColumn', {'fg': s:brown, 'bg': s:pastel_blue})
call s:H('FoldColumn', {'fg': s:brown, 'bg': s:pastel_blue})
call s:H('LineNr', {'fg': s:yellow})
call s:H('ModeMsg', {'attrs': 'bold'})
call s:H('MoreMsg', {'fg': s:blue, 'attrs': 'bold'})
call s:H('Pmenu', {'fg': s:brown, 'bg': s:light_brown})
call s:H('PmenuSel', {'fg': s:brown, 'bg': s:tan, 'attrs': 'bold'})
call s:H('PmenuSbar', {'bg': s:brown})
call s:H('PmenuThumb', {'bg': s:blue})
call s:H('Question', {'fg': s:pink, 'attrs': 'bold'})
call s:H('SignColumn', {'fg': s:brown, 'bg': s:pastel_green})
call s:H('StatusLine', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': 'bold'})
call s:H('StatusLineNC', {'fg': s:brown, 'bg': s:pastel_green})
call s:H('TabLine', {'fg': s:brown, 'bg': s:pastel_green})
call s:H('TabLineFill', {'bg': s:pastel_green})
call s:H('TabLineSel', {'fg': s:brown, 'bg': s:pastel_blue, 'attrs': 'bold'})
call s:H('Title', {'fg': s:red, 'attrs': 'bold'})
call s:H('WarningMsg', {'fg': s:brown, 'bg': s:pink})
call s:H('WildMenu', {'fg': s:brown, 'bg': s:pastel_green})
call s:H('VertSplit', {'fg': s:brown, 'bg': s:pastel_green})

" Use plain old reverse video for the blinking cursor.
" Use an eye-catching shade of green for the blinking cursor.
call s:H('Cursor', {'fg': s:brown, 'bg': s:green})
call s:H('CursorIM', {'fg': s:brown, 'bg': s:green})

" Darken the background of the current line and column.
call s:H('CursorLine', {'bg': s:brown})
call s:H('CursorColumn', {'bg': s:brown})

" Darken the background of the right margin.
call s:H('ColorColumn', {'fg': s:brown, 'bg': s:tan})

" Highlight matched delimiters in a way that's clearly distinguishable from
" unmatched delimiter/statement/preprocessor highlighting.
call s:H('MatchParen', {'fg': s:brown, 'bg': s:light_brown, 'attrs': 'bold'})

" Set up highlights for imaginary '~' and '@' characters, and for special keys.
" The EndOfBuffer group was added by Neovim; Vim uses the NonText group instead.
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
call s:H('DiffText', {'fg': s:brown, 'bg': s:teal, 'attrs': 'bold'})

" Set up custom highlights for bad-whitespace.vim.
call s:H('BadWhitespace', {'fg': s:brown, 'bg': s:red})

" Render TeX macros in preprocessor style. They are macros, after all. :P
highlight link texStatement PreProc
