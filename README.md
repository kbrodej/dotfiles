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
| `tmuxp`    | `~/.config/tmuxp`                |
| `nvim`     | `~/.config/nvim`                 |
| `wezterm`  | `~/.config/wezterm`             |
| `ghostty`  | `~/.config/ghostty`             |
| `scripts`  | `~/scripts` (+ `~/.local/bin/t`) |
| `git`      | `~/.gitconfig`, `~/.gitmessage`  |

## Project sessions (`t` + tmuxp)

One tmux session per project, created from a template that matches the
project type. Requires `fzf` and `tmuxp` (`brew install fzf tmuxp`).

### Opening a project

```bash
t                 # fzf picker over ~/Documents/projects (3 levels deep)
t <path>          # skip the picker, open that path directly (t . works)
t -r [path]       # rebuild: kill the project session and recreate it
                  # from the template (e.g. t -r . inside a project)
```

Inside tmux, `prefix F` opens the same picker in a new window.

If a session for the picked project already exists, `t` switches to it and
touches nothing. Use `-r` to kill it and recreate it from the template
(running programs in it are lost). If no session exists yet, `t` creates
one from the template and switches to it.
The session is named after the last path segment, so
`laravel/unilj/crul` becomes session `crul` (dots become underscores).

The picker hides noise: `vendor`, `node_modules`, hidden dirs and the
top-level `bruno` folder are skipped, and it never descends into a project
root (a dir containing `.git` or a project manifest), so only projects and
grouping folders are listed.

### Starting a new project with a template

Nothing to configure per project. Create the project, then run `t` on it.
The template is chosen by marker files in the project root:

| Marker                  | Template  | Windows                              |
|-------------------------|-----------|--------------------------------------|
| `artisan`               | `laravel` | 1 nvim, 2 claude, 3 ddev, 4 node, 5 term |
| `go.mod` / `Cargo.toml` | `default` | 1 nvim, 2 claude, 3 term             |
| `package.json`          | `fe`      | 1 nvim, 2 claude, 3 node, 4 term     |
| anything else           | `default` | 1 nvim, 2 claude, 3 term             |

Laravel is checked first since those projects also have a `package.json`.

On creation:

- window 1 starts nvim and gets focus, window 2 starts claude
- the laravel `ddev` window runs `ddev start`, but only when the project is
  not already running; it is split into three panes: the ddev pane
  full-height on the left, two stacked on the right
- `node` windows have `npm run dev` pre-typed but not executed; press Enter
  to start it, or edit the line first (e.g. `pnpm dev`)
- the `claude`, `ddev` and `node` windows keep their fixed names in the
  status line (claude would otherwise show its version number, ddev/node
  would show zsh while idle): they set a `@pinned` window option that the
  status format in `.tmux.conf` checks, other windows keep showing the
  running command

Killing a session does not stop ddev; run `ddev stop` yourself if you want
the containers down.

### Templates

Templates live in `tmuxp/.config/tmuxp/` (stowed to `~/.config/tmuxp`) and
receive `TP_SESSION` and `TP_DIR` from `t`. To load one by hand:

```bash
TP_SESSION=myproj TP_DIR=~/Documents/projects/myproj tmuxp load -d laravel
```

Editing a template applies to the next session created, no restow needed.
YAML gotcha: an unquoted command containing `: ` (colon + space) breaks
parsing, so quote such commands or use a `>-` block scalar like the ddev
check does.

Useful tmuxp extras:

```bash
tmuxp ls              # list templates
tmuxp freeze <name>   # snapshot a running session into a YAML config
```

`tmuxp freeze` is the easy way to grow a new template: build the session by
hand, freeze it, clean up the YAML and drop it in `tmuxp/.config/tmuxp/`.
To add a new project type, add the template there and a marker check in
`scripts/scripts/t`.

## Notes

- The tracked `.gitconfig` holds only shareable settings (aliases, colors,
  diff, commit template, signing on by default). Machine-specific identity —
  `[user]` name/email/signingkey and the `gpg.program` path — lives in
  `~/.gitconfig.local`, which the tracked config `[include]`s and which is
  **never committed**. `setup` seeds an empty one on first run.
- Machine-local or secret shell config goes in `~/.zshrc.local`, which `.zshrc`
  sources if present and is never committed.
- Project sessions are managed by `t` +
  [tmuxp](https://github.com/tmux-python/tmuxp), see the section above.
