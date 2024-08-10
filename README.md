# MY WORKFLOW AS A DATA ENGINEER

## Introduction
Here i try to explain as detail as possible about my workflow. This was originaly made to fufil my desire to help people have a better start on their journey.

In this repository, i will try to cover:
- Neovim --> a blazingly fast text editor that work just like an IDE
- Tmux --> an amazing tool that help with managing multiple terminal at once
- Wezterm --> a powerful cross-platform terminal emulator written in rust
- Fishshell --> (potential?) currently using Zsh

My goal when it comes to configure these tools are:
- As minimal as possible (prevent distraction)
- If im not using it then it is useless (never add it in)

**This is just my own configuration, it is recommened that you read every file carefully and make a version of your own**

My config was made possible thank to ['kickstart.nvim'](https://github.com/nvim-lua/kickstart.nvim) by TJ Devries

## Installation

### Dependencies

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons, remember to set `vim.g.have_nerd_font` in `opt` to true if you have this installed
- Language Setup:
  - If want to write Typescript, you need `npm`
  - If want to write Golang, you will need `go`
  - etc.

### Neovim
<details><summary> Linux/WSL </summary>

```sh
git clone https://github.com/ov3ipo/neovim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

## Todolist
[ ] Configure custom statusline
[ ] Make open experience better with oil and starter


