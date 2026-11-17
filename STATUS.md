# STATUS - the task board between Claude and Gemini (all projects)

Last updated by Claude: 17 Nov 2026 (mailbox app Step 1 plan written: plans/mailbox-app-plan.md, waiting for approval)

Rules: Gemini -> `GEMINI.md`. Claude -> `CLAUDE.md`. Projects -> `PROJECTS.md`.
Status words: **open** (waiting) · **doing** · **answered** (saved, not checked yet) · **checked** (Claude checked - see Result) ·
**used** (in the project - commit named) · **blocked** (see Result) · **cancelled**
IDs: G-NNN = a task for Gemini, C-NNN = a task for Claude (e.g. "turn Gemini's draft into real code"). Numbers never reused.

| ID | Project | For | Status | Task file | What | Result / where used |
|---|---|---|---|---|---|---|
| G-001 | smartbot | Gemini | checked | tasks/smartbot/G-001-check-texts.md | Help texts (why it matters / how to fix) for the new audit checks, as CSV | 78 of 78 checks covered (task said 77, list has 78). Cleaned CSV: answers/smartbot/G-001-checks.csv (all cells quoted; Gemini's raw had unquoted commas, fixed by Claude). Lengths within limits, no key clashes. Not yet used in SmartBot. |
| G-002 | smartbot | Gemini | open | tasks/smartbot/G-002-ahrefs-deep-research.md | Deep research: Ahrefs Page explorer presets, Advanced filter, Link explorer, every URL details panel tab, full issue list | - |

## The one prompt Mahmud gives Gemini (always a NEW Gemini chat)
> Import the GitHub repo smartupworldwebsolutions/claudemin (branch main). Read GEMINI.md and follow it. Then do the open Gemini tasks in STATUS.md.
