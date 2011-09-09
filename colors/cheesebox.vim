" Vim color file
" Name: cheesebox.vim
" Description: An oddly-named dark Vim color scheme with just a hint of mint
" Maintainer: Jonathan Rascher <jon@bcat.name>
" Version: 0.1

" Mark cheesebox.vim as a dark theme.
set background=dark

" Reset existing syntax highlights to their default settings.
highlight clear
if exists("syntax_on")
  syntax reset
endif

" Declare the name of this color scheme.
let g:colors_name="cheesebox"

" Set default foreground and background colors.
highlight Normal guifg=#d7f2b6 guibg=#1f1912

" Set up highlights for basic syntax groups.
highlight Comment guifg=#fbb32f guibg=NONE gui=NONE
highlight Constant guifg=#f63f05 guibg=NONE gui=NONE
highlight String guifg=#e5e339 guibg=NONE gui=NONE
highlight Character guifg=#e5e339 guibg=NONE gui=NONE
highlight Identifier guifg=#8cbdda guibg=NONE gui=NONE
highlight Statement guifg=#d80450 guibg=NONE gui=bold
highlight PreProc guifg=#ec6c99 guibg=NONE gui=NONE
highlight Type guifg=#76bc20 guibg=NONE gui=NONE
highlight Special guifg=#fdd182 guibg=NONE gui=NONE
highlight Underlined guifg=#72aed2 guibg=NONE gui=underline
highlight Error guifg=#1f1912 guibg=#d80450 gui=NONE
highlight Todo guifg=#1f1912 guibg=#fbb32f gui=NONE

" Use plain old reverse video for the blinking cursor.
highlight Cursor guifg=NONE guibg=NONE gui=reverse
highlight CursorIM guifg=NONE guibg=NONE gui=reverse

" Use reverse video once again to highlight searches.
highlight IncSearch guifg=#1f1912 guibg=#8cbdda gui=NONE
highlight Search guifg=#1f1912 guibg=#fdd182 gui=NONE

" Darken the background of the current line and column.
highlight CursorLine guibg=#100d0a
highlight CursorColumn guibg=#100d0a

" Lighten the background of the right margin.
highlight ColorColumn guibg=#30271d

" Set a vibrant background for visual mode.
highlight Visual guifg=#0b3302 guibg=#94d900 gui=NONE
highlight VisualNOS guifg=#0b3302 guibg=#d8ff84 gui=NONE

" Fall back to Special highlighting for imaginary `~` and `@` characters.
highlight NonText guifg=#fdd182 guibg=NONE gui=NONE

" Set up custom highlights for bad-whitespace.vim.
highlight BadWhitespace guifg=#1f1912 guibg=#d80450 gui=NONE
