---
name: loom-summary
description: Generate a video summary and chapter markers from a Loom transcript, copied to clipboard
allowed-tools: Bash
argument-hint: "<paste transcript>"
---

# Loom Summary

Generate a concise video summary and chapter markers from a pasted Loom transcript, then copy the result to clipboard.

## Phase 1 — Receive Input

Extract transcript from input:

- Claude Code: use `$ARGUMENTS`
- Pi: text after `User:` marker

If transcript found, proceed to Phase 2.

If no transcript provided, ask the user to paste their Loom transcript.

## Phase 2 — Generate Summary & Chapters

Analyze the transcript and produce:

### Video Summary

- 1-2 sentences, no more than 140 characters
- Captures the primary purpose or outcome of the video

### Chapter Markers

**Step 1 — Estimate video duration:**

- If the transcript contains timestamps, use the last timestamp as the duration
- Otherwise, estimate from word count at ~150 words/minute speaking rate

**Step 2 — Determine chapter count from duration:**

- Under 1 minute → 2 chapters
- 1–3 minutes → 3 chapters
- 3–5 minutes → 4 chapters
- Over 5 minutes → 5 chapters
- Hard bounds: never fewer than 2, never more than 5

**Step 3 — Generate markers:**

- Each marker: 3–5 words
- Format: `mm:ss Description`
- First marker MUST be `00:00`
- If the transcript contains timing data (e.g., `[00:00]`, `[01:23]`), use those timestamps
- If no timing data is present, distribute markers evenly across the estimated duration and note that timestamps are approximate

## Phase 3 — Copy to Clipboard

Format the output exactly as:

```
Summary: <summary>

Chapters:
mm:ss Description
mm:ss Description
```

Copy to clipboard using:

```bash
printf '%s' '<formatted output>' | pbcopy
```

Confirm to the user that the result is on their clipboard and ready to paste into Loom.

## Rules

- macOS only — uses `pbcopy`
- No PR updates, no GitHub integration — just transcript to clipboard
- No Loom URL fetching — user pastes transcript directly
- Keep chapter descriptions concise: 3–5 words each
