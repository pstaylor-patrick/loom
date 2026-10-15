# loom-skills

Slash commands for working with Loom videos. Works in Claude Code and Pi.

## Skills

### `/loom-summary`

Paste a Loom transcript and get a video summary + chapter markers copied to your clipboard, ready to paste into Loom.

## Install

```bash
./install.rb
```

Creates symlinks in:

- Claude Code: `~/.claude/commands/loom-summary.md`
- Pi: `~/.agents/skills/loom-summary/SKILL.md` and `~/.pi/agent/skills/loom-summary/SKILL.md`

To remove:

```bash
./install.rb --uninstall
```

## Usage

Claude Code:

```
/loom-summary <paste your Loom transcript here>
```

Pi:

```
/skill:loom-summary <paste your Loom transcript here>
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
