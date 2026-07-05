# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a stow "package" that mirrors its layout relative to `$HOME`.

## Install

```bash
chmod +x setup
./setup
```

This stows every package listed in `setup`. To install a single package:

```bash
stow zsh        # links ~/.zshrc
stow nvim       # links ~/.config/nvim
```

To remove one:

```bash
stow -D tmux    # unlinks ~/.tmux.conf
```

## Packages

| Package    | Links                            |
|------------|----------------------------------|
| `zsh`      | `~/.zshrc`                       |
| `tmux`     | `~/.tmux.conf`                   |
| `nvim`     | `~/.config/nvim`                 |
| `wezterm`  | `~/.config/wezterm`             |
| `scripts`  | `~/scripts` (+ `~/.local/bin/t`) |
| `git`      | `~/.gitconfig`, `~/.gitmessage`  |

## Notes

- The tracked `.gitconfig` holds only shareable settings (aliases, colors,
  diff, commit template, signing on by default). Machine-specific identity —
  `[user]` name/email/signingkey and the `gpg.program` path — lives in
  `~/.gitconfig.local`, which the tracked config `[include]`s and which is
  **never committed**. `setup` seeds an empty one on first run.
- Machine-local or secret shell config goes in `~/.zshrc.local`, which `.zshrc`
  sources if present and is never committed.
