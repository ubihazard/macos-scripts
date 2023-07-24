## Add user executables to Path

Create user `bin` directory and populate it with binaries and [shell scripts](/ubihazard/macos-scripts/tree/main/.local/bin "Scripts"):

```bash
mkdir -p $HOME/.local/bin
```

Add it to your `PATH` in `.bash_profile` (`nano $HOME/.bash_profile`):

```bash
export PATH=$HOME/.local/bin:$PATH
```

If you are using `zsh` as your shell (as is the case by default in modern macOS), add this to your `.zshrc`:

```bash
source ~/.bash_profile
```

Restart terminal or open new terminal window (or tab) with new `bash` or `zsh` (or other shell) session for changes to take effect.

# ⭐ Support

If you find anything of this useful, you can [buy me a ☕](https://www.buymeacoffee.com/ubihazard "Donate")!
