# autobg.nvim

Automatically set Neovim's background and colorscheme based on your system's dark/light theme.

## Features

- Detects system theme (dark/light) on **macOS**, **Linux (GNOME)**, and **Windows**
- Sets `vim.opt.background` to match your system theme
- Optionally sets a colorscheme for dark or light mode

## Installation

Use your favorite plugin manager.

### With [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'mCassy/autobg.nvim',
  config = function()
    require('autobg').setup()
  end,
}
```

### With [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'mCassy/autobg.nvim',
  config = function()
    require('autobg').setup()
  end
}
```

## Usage

Basic setup (auto-detects system theme and sets Neovim background):

```lua
require('autobg').setup()
```

Optionally, specify colorschemes for dark and light modes:

```lua
require('autobg').setup {
  dark = 'tokyonight',   -- colorscheme for dark mode
  light = 'github_light' -- colorscheme for light mode
}
```

## Configuration

| Option | Type   | Description                           |
| ------ | ------ | ------------------------------------- |
| dark   | string | Colorscheme for dark mode (optional)  |
| light  | string | Colorscheme for light mode (optional) |

## Supported Platforms

- **macOS**: Uses `defaults read -g AppleInterfaceStyle`
- **Linux (GNOME)**: Uses `gsettings get org.gnome.desktop.interface color-scheme`
- **Windows**: Reads registry key for theme preference

## Contributing

Pull requests and issues are welcome!

## License

MIT
