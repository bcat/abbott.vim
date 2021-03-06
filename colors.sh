#!/bin/bash

# abbott.vim <https://github.com/bcat/abbott.vim>
# A warm, dark color scheme for prose and code, with pastels and pretty greens.
#
# Copyright 2020-2021 Jonathan Rascher
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

true_colors=(
  # Terminal colors:
  231c14  # 0: bistre
  d80450  # 1: crimson
  24a507  # 2: forest_green
  fbb32f  # 3: marigold
  3f91f1  # 4: cornflower_blue
  ec6c99  # 5: french_pink
  39a78d  # 6: zomp
  d8ff84  # 7: pastel_chartreuse
  745d42  # 8: cocoa
  f63f05  # 9: cinnabar
  a0ea00  # 10: chartreuse
  fbec5d  # 11: lemon_meringue
  8ccdf0  # 12: periwinkle_blue
  e6a2f3  # 13: lavender
  00ff7f  # 14: seafoam_green
  fef3b4  # 15: vanilla_cream

  # Additional colors:
  3c3022  # chocolate
  273900  # dark_olive
)

indexed_colors=(
  # Terminal colors:
  234  # 0: bistre
  161  # 1: crimson
  34  # 2: forest_green
  214  # 3: marigold
  33  # 4: cornflower_blue
  204  # 5: french_pink
  36  # 6: zomp
  192  # 7: pastel_chartreuse
  241  # 8: cocoa
  202  # 9: cinnabar
  154  # 10: chartreuse
  227  # 11: lemon_meringue
  117  # 12: periwinkle_blue
  219  # 13: lavender
  48  # 14: seafoam_green
  229  # 15: vanilla_cream

  # Additional colors:
  236  # chocolate
  238  # dark_olive
)

set_rgb_color () {
  local r=$((16#${1:0:2})) g=$((16#${1:2:2})) b=$((16#${1:4:2}))
  printf '\e[38;2;%s;%s;%sm' "$r" "$g" "$b"
}

printf_white () {
  tput setaf 231
  printf "$@"
}

print_colors () {
  local color_list=$1
  shift

  # Header:
  if (( $1 < 16 )); then
    for i; do
      printf_white '  ANSI %2d ' "$i"
    done
    printf '\n'
  fi

  # Colors:
  for row in {0..3}; do
    for i; do
      printf ' '
      if [[ $color_list == true ]]; then
        set_rgb_color "${true_colors[i]}"
      else
        tput setaf "${indexed_colors[i]}"
      fi
      tput rev
      printf '         '
      tput sgr0
      tput setab 16  # Black (#000000)
    done
    printf '\n'
  done

  # Footer:
  for i; do
  if [[ $color_list == true ]]; then
    printf_white '  #%s ' "${true_colors[i]}"
  else
    printf_white '    %3s   ' "${indexed_colors[i]}"
  fi
  done
  printf '\n'
}

case $1 in
  approx)
    # Uses this Python script to compute the approximations:
    # https://github.com/bcat/dotfiles/blob/master/bin/termapprox.
    for color in "${true_colors[@]}"; do
      termapprox -stn16 "$color"
    done
    ;;

  indexed|true)
    # Switch to the alternate screen and hide the cursor.
    tput smcup
    tput civis

    # Blank the screen and reset cursor to the top left.
    tput setab 16  # Black (#000000)
    clear

    # Print the color palette.
    printf_white 'abbott.vim color palette (%s color)\n\n' "$1"
    printf_white 'Terminal colors:\n\n'
    print_colors "$1" {0..7}
    printf '\n'
    print_colors "$1" {8..15}
    printf_white '\nAdditional colors:\n\n'
    print_colors "$1" {16..17}

    # Wait for input before exiting.
    read -r

    # Restore the cursor and exit the alternate screen.
    tput cnorm
    tput rmcup
    ;;

  *)
    printf "\
usage: colors.sh approx|indexed|true

Display the abbott.vim color palette or approximate true colors with 256 colors.
" >&2
    exit 2
esac
