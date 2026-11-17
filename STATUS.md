# STATUS - the task board between Claude and Gemini (all projects)

Last updated by Claude: 17 Nov 2026 (mailbox plan APPROVED with server rules: plans/mailbox-app-plan.md; next is Step 2)

Rules: Gemini -> `GEMINI.md`. Claude -> `CLAUDE.md`. Projects -> `PROJECTS.md`.
Status words: **open** (waiting) · **doing** · **answered** (saved, not checked yet) · **checked** (Claude checked - see Result) ·
**used** (in the project - commit named) · **blocked** (see Result) · **cancelled**
IDs: G-NNN = a task for Gemini, C-NNN = a task for Claude (e.g. "turn Gemini's draft into real code"). Numbers never reused.

| ID | Project | For | Status | Task file | What | Result / where used |
|---|---|---|---|---|---|---|
| G-001 | smartbot | Gemini | checked | tasks/smartbot/G-001-check-texts.md | Help texts (why it matters / how to fix) for the new audit checks, as CSV | 78 of 78 checks covered (task said 77, list has 78). Cleaned CSV: answers/smartbot/G-001-checks.csv (all cells quoted; Gemini's raw had unquoted commas, fixed by Claude). Lengths within limits, no key clashes. Not yet used in SmartBot. |
| G-002 | smartbot | Gemini | open | tasks/smartbot/G-002-ahrefs-deep-research.md | Deep research: Ahrefs Page explorer presets, Advanced filter, Link explorer, every URL details panel tab, full issue list | - |
| G-003 | smartbot | Gemini | open | tasks/smartbot/G-003-blog-plan-and-drafts.md | Blog: 40 article ideas + 8 full drafts for SmartBot's public blog | - |

Decision 17 Nov 2026: mailbox app on the Plesk VPS is SHELVED (Mahmud will not pay for the Gemini API). Jules is shut down (31 Dec 2026). Manual flow below is the final one.

## How a Gemini task runs (manual, simple - Gemini cannot write to GitHub)
1. Claude writes the task file in tasks/<project>/ and runs `./make_pack.sh G-NNN` (one file with the rules + task + context), sends it to Mahmud.
2. Mahmud opens a NEW Gemini chat, attaches the pack (+ > Upload files), types: Read this file fully and do the task in it. Send long answers in parts.
3. Mahmud pastes/attaches Gemini's answer in the Claude chat. Claude checks it, fixes the format, commits it to answers/<project>/, sets the status here.
(Do NOT use Gemini 'Import code': it shows the repo as unreadable compressed bytes.)
