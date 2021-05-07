# `abbott.vim`

`abbott.vim` is a warm, dark color scheme for prose and code, with pastels and
pretty greens. It's primarily designed for editing files with a lot of plain
text (i.e., Markdown or TeX documents), but it handles executable code well too.
This color scheme draws inspiration from several sources, including memories of
late nights working mathematical proofs—it's named after Stephen Abbott's
_Understanding Analysis_, which I was studying at the time—and drinking copious
quantities of Mountain Dew.

## Screenshots

Because hey, it's a color scheme! That's what you really want to see, right?

[![abbott.vim 2.1:
Vimscript](https://i.imgur.com/TpuJttd.png)](https://imgur.com/TpuJttd)

[![abbott.vim 2.1:
Python](https://i.imgur.com/PSZu7oU.png)](https://imgur.com/PSZu7oU)

[![abbott.vim 2.1:
Markdown](https://i.imgur.com/MQA3MCi.png)](https://imgur.com/MQA3MCi)

[![abbott.vim 2.1:
C](https://i.imgur.com/rSJ2Hs4.png)](https://imgur.com/rSJ2Hs4)

Compare to [screenshots from older versions](https://imgur.com/a/7woPY) to see
how this color scheme has evolved.

## Colors

This color scheme uses a 16-color palette that maps nicely onto the ANSI color
palette, plus a couple of additional colors for terminals that allow them:

[![abbott.vim 2.1: Color Palette (True
Color)](https://i.imgur.com/8p1dEP3.png)](https://imgur.com/8p1dEP3)

`abbott.vim` looks best where RGB colors are supported, either in the gVim GUI
or in [a terminal supporting true
colors](https://github.com/termstandard/colors) with Vim's `termguicolors`
option enabled. You can use this color scheme in a 256-color terminal instead,
if you like, and you'll get the following approximated palette:

[![abbott.vim 2.1: Color Palette (Indexed
Color)](https://i.imgur.com/ZkbmjkR.png)](https://imgur.com/ZkbmjkR)

The colors are pretty close, but the brown and olive colors are replaced with
shades of gray since the XTerm 256-color palette doesn't have many shades of
brown to choose from.

## Features

* This color scheme is a dark theme that attempts to avoid excessive text
  contrast. Plain text is light green on dark brown to be easy on the eyes after
  long hours. Additionally, care has been taken to ensure the color palette
  looks decent in "night light" mode (e.g., with
  [f.lux](https://justgetflux.com/) or other blue light filters enabled).
* This color scheme supports all highlight groups in Vim 8.2, as well as the
  [Better Whitespace](https://github.com/ntpeters/vim-better-whitespace) plugin.
* Additional plugin-specific highlight groups may be added in the future.

## Options

This color scheme offers some additional features that are disabled by default
because they may not interact well with all terminals or with other Vim color
schemes. These features can be enabled if the user likes to live dangerously.

```vim
let g:abbott_force_16_colors = 1
```

If requested by the user, restrain ourselves to only the 16 standard ANSI
terminal colors even if Vim thinks the terminal supports 256 colors. This allows
the user to configure their terminal emulator to use the 16 colors defined above
for its ANSI palette, allowing exact color matches rather than 256-color
approximations even in terminals that don't support true color.

```vim
let g:abbott_set_term_ansi_colors = 1
```

If requested by the user, use our standard 16-color palette for the embedded
terminal. We don't do this by default because unlike the highlight groups above,
this isn't automatically cleared when another color scheme is selected.

```vim
let g:abbott_term_use_italics = 1
```

By default, Italics in the terminal are disabled since the default terminfo for
GNU Screen renders italics as reverse video, and since other terminals like
hterm may show artifacts when rendering italics.

```vim
let g:abbott_term_set_underline_color = 1
```

By default, the foreground text color will be replaced by the underline color in
the terminal since if the terminal does not support setting the underline color
separately, that color will be completely invisible.

```vim
let g:abbott_term_use_undercurl = 1
```

By default, underlined text will be used in the terminal in place of undercurl,
because some terminfo entries cause Vim to think the terminal supports undercurl
[when it really does not](https://github.com/vim/vim/issues/3471).

## Contributing

This color scheme is licensed under the [ISC
license](https://github.com/bcat/abbott.vim/blob/master/LICENSE). Folks are free
to port this color scheme to other editors and environments if they would like,
and are encouraged to submit fixes back to the canonical `abbott.vim` repository
if possible. Likewise, patches to support new Vim features are always welcome.
Consult the [changelog](CHANGES.md) for version history.
