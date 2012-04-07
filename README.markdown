`abbott.vim` is an oddly-named dark Vim color scheme. It's primarily designed
for editing files with a lot of plain text (i.e., TeX documents), but it
should be fairly decent for other sorts of files as well. The color scheme
draws on several sources, including memories of late nights spent working on
real analysis homework and drinking copious amounts of Mountain Dew.

# Screenshots #

Because hey, it's a color scheme! That's what you really want to see, right?

![(abbott.vim editing this README)](http://i.imgur.com/9jbDG.png)

([More here.][1])

# Features & characteristics #

*   `abbott.vim` is a dark theme and only a dark theme.
*   `abbott.vim` is not a low contrast theme; however, does attempt to avoid
    excessive text contrast. Plain text is light green on dark brown rather
    than white on black.
*   `abbott.vim` supports all highlight groups featured in Vim 7.3, as well as
the [bad-whitespace][2] plugin.
*   `abbott.vim` currently sets only GUI colors. Terminal users are encouraged
to try it with the [CSApprox][3] plugin as this seems to give decent results.

# Future directions #

*   Make the color choices suck less. (May be impossible given my lack of
artistic talent.)
*   Add custom highlights for other plugins. (Ideas, anyone?)
*   Add native support for 88- and 256-color terminals. (CSApprox is great,
    but I think hand-picked terminal colors would give nicer looking
    approximations in some cases.)

[1]: http://imgur.com/a/7woPY
[2]: https://github.com/bitc/vim-bad-whitespace
[3]: https://github.com/godlygeek/csapprox
