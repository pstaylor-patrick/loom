# loom-skills

Claude Code slash commands for working with Loom videos.

## Skills

### `/loom-summary`

Paste a Loom transcript and get a video summary + chapter markers copied to your clipboard, ready to paste into Loom.

## Install

```bash
./install.rb
```

This symlinks the skill into `~/.claude/commands/` so it's available as a slash command in Claude Code.

To remove:

```bash
./install.rb --uninstall
```

## Usage

In a Claude Code session:

```
/loom-summary <paste your Loom transcript here>
```

### Example output

```
Summary: Walkthrough of the new auth flow showing login, token refresh, and error handling

Chapters:
00:00 Auth flow overview
00:45 Login implementation
01:30 Token refresh logic
02:15 Error handling patterns
03:00 Testing the flow
```
