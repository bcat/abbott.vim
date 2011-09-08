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
highlight Normal guifg=#cff0a7 guibg=#1b1610
