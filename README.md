# SetColorSchemes.vim

Provide easy keymaps to change the Vim/Neovim colorscheme and Airline theme.

## Installation

Automatically installed during
[Asciiville](https://github.com/doctorfree/Asciiville)
initialization.

Install via [Pathogen](https://github.com/tpope/vim-pathogen):

    cd ~/.vim/bundle
    git clone https://github.com/doctorfree/SetColorSchemes.vim.git SetColorSchemes

Install via [vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'doctorfree/SetColorSchemes.vim'

## Configuration

Default list of colorschemes through which to cycle:

    ['asciiville', 'everforest', 'cool', 'desertink', 'distinguished', 'hybrid', 'luna', 'molokai', 'solarized', 'zenburn']

Override list of colorschemes through which to cycle, for example:

    let g:mycolorschemes = ['asciiville', 'everforest', 'cool', 'desertink']

## Usage

Sets the Vim/Neovim colorscheme from a list of configured colorschemes and
sets the Airline theme to the same colorscheme as the selected colorscheme.

Cycle through colorschemes and corresponding airline themes using the default
key mappings:

    <F7> Previous colorscheme and airline theme
    <F8> Next colorscheme and airline theme
    <F9> Random colorscheme and airline theme

For example, when `<F8>` is pressed the next colorscheme in the list is used.
Note that both the Neovim colorscheme and the Airline theme are set. These
two color schemes need to be coordinated to provide proper contrast and
readability. The default colorschemes above take care of this. If you change
the `mycolorschemes` global variable make sure to use color schemes with
compatible [Airline themes](https://github.com/vim-airline/vim-airline-themes).

Set the list of color schemes used by the above (default is 'all'):

```vim
:SetColorSchemes all                     " all $VIMRUNTIME/colors/*.vim
:SetColorSchemes my                      " names built into script
:SetColorSchemes asciiville everforest   " these schemes
:SetColorSchemes                         " display current scheme names
```

Set the current color scheme based on time of day:

```vim
:SetColorSchemes now
```

## Credits

Inspired by and based on [setcolors.vim](https://github.com/felixhummel/setcolors.vim)
which in turn was based on https://vim.fandom.com/wiki/Switch_color_schemes#Script
