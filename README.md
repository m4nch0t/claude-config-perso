# claude-config-perso

My personal Claude Code configuration: global `CLAUDE.md`, `settings.json`,
agents, commands and skills.

## Install on a machine

```sh
git clone git@github.com:m4nch0t/claude-config-perso.git ~/workspace/claude-config-perso
sh ~/workspace/claude-config-perso/install.sh   # links files into ~/.claude, clones ~/workspace/claude-memory
sh ~/workspace/claude-config-perso/doctor.sh    # checks links, repo sync, tools
```

The memory repo (`m4nch0t/claude-memory`) is private. `install.sh` clones it
over SSH. Set `CLAUDE_MEMORY_URL=` (empty) to skip it.

`settings.json` "env" is not always honored for auto-compact, so also export
`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50` in your shell. On my Mac it is in
`~/.zshenv`, from the `m4nch0t/dotfiles` repo. The sandbox image sets it.

## Docker Sandbox image

GitHub Actions builds `sandbox/Dockerfile` on each push to `main` and every
Monday, for `linux/amd64` and `linux/arm64`:

```sh
docker pull ghcr.io/m4nch0t/claude-sandbox:latest
```

The `docker sandbox` command was removed from Docker Desktop. Use the image
as a custom template in Docker Sandboxes (see Docker's docs for the command).

The image has this config but not the memory repo, because the image is
public. To use memory inside a sandbox, use a fine-grained token limited to
`claude-memory` (contents: read and write):

```sh
git clone https://github.com/m4nch0t/claude-memory.git ~/workspace/claude-memory
sh ~/workspace/claude-config-perso/install.sh
```
