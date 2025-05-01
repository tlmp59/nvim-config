### Treesitter
By default neovim come with treesitter builtin, this get mentioned on the offical [documentation](https://neovim.io/doc/user/treesitter.html) of Neovim

### LSP
LSP stands for Language Server Protocol. It's a protocol that helps editors
and language tooling communicate in a standardized fashion.

In general, you have a "server" which is some tool built to understand a particular
language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
(sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
processes that communicate with some "client" - in this case, Neovim!

LSP provides Neovim with features like:
    - Go to definition
    - Find references
    - Autocompletion
    - Symbol Search
    - and more!

Thus, Language Servers are external tools that must be installed separately from
Neovim. This is where `mason` and related plugins come into play.

If you're wondering about lsp vs treesitter, you can check out the wonderfully
and elegantly composed help section, `:help lsp-vs-treesitter`

Check `:help lsp` for more information about the expected workflow with lsp

New Neovim version 0.11+ added new vim.lsp APIs that support natively LSP config, these include:
    - vim.lsp.config()
    - vim.lsp.enable() ~ Already have builtin FileType detection

### Linter
A tool that analyzes source code to flag programming errors, bugs, stylistic errors, and suspicious constructs.
- TODO: conduct a comparison with LSP and understand the reason why we need this
