" abbott.vim <https://github.com/bcat/abbott.vim>
" A warm, dark color scheme for prose and code, with pastels and pretty greens.
"
" Copyright 2011-2013, 2015, 2017, 2020-2021 Jonathan Rascher
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

" Define 16 colors that map reasonably well onto the standard ANSI color
" palette. Indeed, the terminal emulator can be configured to use these colors
" instead of its standard palette without issues.
"
" Approximations for 256-color terminals were chosen with the colors.sh script.
" Unfortunately, the XTerm 256-color palette doesn't contain many shades of
" brown, so we approximate bistre (ANSI 0) and cocoa (ANSI 8) using gray
" instead. Additionally, we use a slightly brighter approximation for cinnabar
" and French pink because the closest approximations look too reddish and too
" dull, respectively.

" ANSI black (0), bright black (8):
let s:bistre = {'rgb': '#231c14', 'term256': '234', 'term16': '0'}
let s:cocoa = {'rgb': '#745d42', 'term256': '241', 'term16': '8'}

" ANSI red (1), bright red (9):
let s:crimson = {'rgb': '#d80450', 'term256': '161', 'term16': '1'}
let s:cinnabar = {'rgb': '#f63f05', 'term256': '202', 'term16': '9'}

" ANSI green (2), bright green (10):
let s:forest_green = {'rgb': '#24a507', 'term256': '34', 'term16': '2'}
let s:chartreuse = {'rgb': '#a0ea00', 'term256': '154', 'term16': '10'}

" ANSI yellow (3), bright yellow (11):
let s:marigold = {'rgb': '#fbb32f', 'term256': '214', 'term16': '3'}
let s:lemon_meringue = {'rgb': '#fbec5d', 'term256': '227', 'term16': '11'}

" ANSI blue (4), bright blue (12):
let s:cornflower_blue = {'rgb': '#3f91f1', 'term256': '33', 'term16': '4'}
let s:periwinkle_blue = {'rgb': '#8ccdf0', 'term256': '117', 'term16': '12'}

" ANSI magenta (5), bright magenta (13):
let s:french_pink = {'rgb': '#ec6c99', 'term256': '204', 'term16': '5'}
let s:lavender = {'rgb': '#e6a2f3', 'term256': '219', 'term16': '13'}

" ANSI cyan (6), bright cyan (14):
let s:zomp = {'rgb': '#39a78d', 'term256': '36', 'term16': '6'}
let s:seafoam_green = {'rgb': '#00ff7f', 'term256': '48', 'term16': '14'}

" ANSI white (7), bright white (15):
let s:pastel_chartreuse = {'rgb': '#d8ff84', 'term256': '192', 'term16': '7'}
let s:vanilla_cream = {'rgb': '#fef3b4', 'term256': '229', 'term16': '15'}

" Additionally, define an extra shade of brown for use in highlighted lines and
" columns. For 256-color terminals, we map this to a shade of gray like bistre
" and cocoa. For 16-color terminals, since we don't have an extra color, we map
" this to the same color as cocoa. That doesn't give a ton of contrast, but it's
" the best we can do.

let s:chocolate = {'rgb': '#3c3022', 'term256': '236', 'term16': '8'}

" This color scheme offers some additional features that are disabled by default
" because they may not interact well with all terminals or with other Vim color
" schemes. These features can be enabled if the user likes to live dangerously.

" If requested by the user, restrain ourselves to only the 16 standard ANSI
" terminal colors even if Vim thinks the terminal supports 256 colors. This
" allows the user to configure their terminal emulator to use the 16 colors
" defined above for its ANSI palette, allowing exact color matches rather than
" 256-color approximations even in terminals that don't support true color.
if !exists('g:abbott_force_16_colors')
  let g:abbott_force_16_colors = 0
endif

" If requested by the user, use our standard 16-color palette for the embedded
" terminal. We don't do this by default because unlike the highlight groups
" above, this isn't automatically cleared when another color scheme is selected.
if !exists('g:abbott_set_term_ansi_colors')
  let g:abbott_set_term_ansi_colors = 0
endif

" By default, the foreground text color will be replaced by the underline color
" in the terminal since if the terminal does not support setting the underline
" color separately, that color will be completely invisible.
if !exists('g:abbott_term_set_underline_color')
  let g:abbott_term_set_underline_color = 0
endif

" By default, Italics in the terminal are disabled since the default terminfo
" for GNU Screen renders italics as reverse video, and since other terminals
" like hterm may show artifacts when rendering italics.
if !exists('g:abbott_term_use_italics')
  let g:abbott_term_use_italics = 0
endif

" By default, underlined text will be used in the terminal in place of
" undercurl, because some terminfo entries cause Vim to think the terminal
" supports undercurl when it really does not
" (https://github.com/vim/vim/issues/3471).
if !exists('g:abbott_term_use_undercurl')
  let g:abbott_term_use_undercurl = 0
endif

" Returns the appropriate color index for the current terminal. We currently
" only have special support for the 256-color XTerm palette. All other terminals
" get the standard 16-color ANSI palette.
"
" We could add support for the 88-color XTerm palette or legacy
" XTerm-incompatible 256-color palettes, but it doesn't seem worth the effort.
"
" Direct color (a.k.a. true color or 24-bit color) is handled differently: if
" the termguicolors option is set, Vim uses guifg/guibg/guisp, and
" ctermfg/ctermbg/ctermul are ignored.
function! s:TermColor(color)
  return &t_Co >= 256 && !g:abbott_force_16_colors ? a:color.term256
      \ : a:color.term16
endfunction

" Returns whether Vim supports the ctermul highlight parameter.
function! s:HasTermUnderlineColor()
  return has('patch-8.2.863')
endfunction

" Highlights {group} according to the configuration given in {style}. The style
" dictionary may have color constant values with keys 'fg', 'bg', and 'sp' to
" set the highlight group's foreground, background, and underline colors,
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

  " Set up terminal foreground and underline colors. If the current version of
  " Vim can't set underline color in the terminal or if the user does not wish
  " us to use that option (e.g., because their terminal doesn't support it),
  " then we *replace* the foreground color with the underline ("special") color.
  if has_key(a:style, 'sp')
    if s:HasTermUnderlineColor() && g:abbott_term_set_underline_color
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
      \ 'ctermfg=' (exists('l:term_fg') ? s:TermColor(l:term_fg) : 'NONE')
      \ 'ctermbg=' . (has_key(a:style, 'bg') ? s:TermColor(a:style.bg) : 'NONE')
      \ (s:HasTermUnderlineColor() ?
          \ 'ctermul=' . (exists('l:term_sp') ? s:TermColor(l:term_sp) : 'NONE')
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
call s:H('Normal', {'fg': s:pastel_chartreuse, 'bg': s:bistre})

" Set up highlights for basic syntax groups.
call s:H('Comment', {'fg': s:marigold, 'attrs': ['italic']})
call s:H('Constant', {'fg': s:cinnabar})
call s:H('String', {'fg': s:lavender})
call s:H('Character', {'fg': s:lavender})
call s:H('Identifier', {'fg': s:periwinkle_blue})
call s:H('Function', {'fg': s:cornflower_blue})
call s:H('Statement', {'fg': s:crimson, 'attrs': ['bold']})
call s:H('Operator', {'attrs': ['bold']})
call s:H('PreProc', {'fg': s:french_pink})
call s:H('Type', {'fg': s:forest_green})
call s:H('Special', {'fg': s:vanilla_cream})
call s:H('Tag', {'fg': s:lavender, 'attrs': ['underline']})
call s:H('Underlined', {'fg': s:lavender, 'attrs': ['underline']})
call s:H('Ignore', {'fg': s:cocoa})
call s:H('Error', {'fg': s:bistre, 'bg': s:crimson})
call s:H('Todo', {'fg': s:bistre, 'bg': s:marigold})

" Set up highlights for various UI elements.
call s:H('ErrorMsg', {'fg': s:bistre, 'bg': s:crimson})
call s:H('FoldColumn', {'fg': s:marigold})
call s:H('Folded', {'fg': s:cinnabar})
call s:H('LineNr', {'fg': s:lemon_meringue})
call s:H('ModeMsg', {'attrs': ['bold']})
call s:H('MoreMsg', {'fg': s:cornflower_blue, 'attrs': ['bold']})
call s:H('Pmenu', {'fg': s:vanilla_cream, 'bg': s:cocoa})
call s:H('PmenuSel', {'fg': s:bistre, 'bg': s:vanilla_cream, 'attrs': ['bold']})
call s:H('PmenuSbar', {'bg': s:cocoa})
call s:H('PmenuThumb', {'bg': s:bistre})
call s:H('Question', {'fg': s:french_pink, 'attrs': ['bold']})
call s:H('QuickFixLine',
    \ {'fg': s:bistre, 'bg': s:vanilla_cream, 'attrs': ['bold']})
call s:H('SignColumn', {'fg': s:bistre, 'bg': s:zomp})
call s:H('StatusLine',
    \ {'fg': s:bistre, 'bg': s:cornflower_blue, 'attrs': ['bold']})
call s:H('StatusLineNC', {'fg': s:bistre, 'bg': s:zomp})
call s:H('StatusLineTerm',
    \ {'fg': s:bistre, 'bg': s:cornflower_blue, 'attrs': ['bold']})
call s:H('StatusLineTermNC', {'fg': s:bistre, 'bg': s:zomp})
call s:H('TabLine', {'fg': s:bistre, 'bg': s:zomp})
call s:H('TabLineFill', {'bg': s:zomp})
call s:H('TabLineSel',
    \ {'fg': s:bistre, 'bg': s:cornflower_blue, 'attrs': ['bold']})
call s:H('Title', {'fg': s:crimson, 'attrs': ['bold']})
call s:H('WarningMsg', {'fg': s:bistre, 'bg': s:french_pink})
call s:H('WildMenu', {'fg': s:bistre, 'bg': s:vanilla_cream, 'attrs': ['bold']})
call s:H('VertSplit', {'fg': s:bistre, 'bg': s:zomp})

" Use an eye-catching shade of green for the blinking cursor.
call s:H('Cursor', {'fg': s:bistre, 'bg': s:chartreuse})
call s:H('CursorIM', {'fg': s:bistre, 'bg': s:seafoam_green})

" Bold the current line and column; highlight the current line number.
call s:H('CursorLine', {'bg': s:chocolate})
call s:H('CursorLineNr', {'bg': s:chocolate, 'attrs': ['bold']})
call s:H('CursorColumn', {'bg': s:chocolate})

" Lighten the background of the right margin.
call s:H('ColorColumn', {'bg': s:chocolate})

" Highlight matched delimiters in a way that's clearly distinguishable from
" unmatched delimiter/statement/preprocessor highlighting.
call s:H('MatchParen', {'fg': s:bistre, 'bg': s:cocoa, 'attrs': ['bold']})

" Set up highlights for imaginary '~' and '@' characters, and for special keys.
call s:H('EndOfBuffer', {'fg': s:cocoa})
call s:H('NonText', {'fg': s:seafoam_green})
call s:H('SpecialKey', {'fg': s:seafoam_green})

" Set a vibrant background for visual mode.
call s:H('Visual', {'fg': s:bistre, 'bg': s:chartreuse})
call s:H('VisualNOS', {'fg': s:bistre, 'bg': s:seafoam_green})

" Use cold highlights for incremental searching and warm highlights for final
" search results.
call s:H('IncSearch', {'fg': s:bistre, 'bg': s:seafoam_green})
call s:H('Search', {'fg': s:bistre, 'bg': s:vanilla_cream})

" Set up spell-checking in an unobtrusive way.
call s:H('SpellBad', {'sp': s:crimson, 'attrs': ['undercurl']})
call s:H('SpellCap', {'sp': s:periwinkle_blue, 'attrs': ['undercurl']})
call s:H('SpellLocal', {'sp': s:lemon_meringue, 'attrs': ['undercurl']})
call s:H('SpellRare', {'sp': s:french_pink, 'attrs': ['undercurl']})

" Don't do anything special for concealed tokens.
call s:H('Conceal', {})

" Set highlights for directory listings.
call s:H('Directory', {'fg': s:periwinkle_blue})

" Use readable diff highlights. :)
call s:H('DiffAdd', {'fg': s:bistre, 'bg': s:chartreuse, 'attrs': ['bold']})
call s:H('DiffChange', {'fg': s:bistre, 'bg': s:french_pink})
call s:H('DiffDelete', {'fg': s:bistre, 'bg': s:crimson})
call s:H('DiffText', {'fg': s:bistre, 'bg': s:seafoam_green, 'attrs': ['bold']})

" Set up custom highlights for better-whitespace.vim.
call s:H('ExtraWhitespace', {'fg': s:bistre, 'bg': s:crimson})

" Set up custom highlights for diff.vim
highlight link diffAdded DiffAdd
highlight link diffRemoved DiffDelete

" Set up custom highlights for gitcommit.vim.
call s:H('gitcommitSummary', {'attrs': ['bold']})
highlight link gitcommitOverflow Error

" Set up custom highlights for tex.vim.
highlight link texStatement PreProc

" Set up the embedded terminal.
if g:abbott_set_term_ansi_colors
  let g:terminal_ansi_colors = [
      \ s:bistre.rgb,
      \ s:crimson.rgb,
      \ s:forest_green.rgb,
      \ s:marigold.rgb,
      \ s:cornflower_blue.rgb,
      \ s:french_pink.rgb,
      \ s:zomp.rgb,
      \ s:pastel_chartreuse.rgb,
      \ s:cocoa.rgb,
      \ s:cinnabar.rgb,
      \ s:chartreuse.rgb,
      \ s:lemon_meringue.rgb,
      \ s:periwinkle_blue.rgb,
      \ s:lavender.rgb,
      \ s:seafoam_green.rgb,
      \ s:vanilla_cream.rgb,
      \ ]
endif
