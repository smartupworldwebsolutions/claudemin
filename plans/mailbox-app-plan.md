# Mailbox app - design plan (Step 1)

Written by Claude, 17 Nov 2026. Status: **waiting for Mahmud's approval. No code yet.**
Goal: Claude posts a task, a small worker on a server asks Gemini, the answer comes back to Claude. No copy-paste by Mahmud.
The manual bridge (Gemini app + `bridge/inbox` on the PC) stays as the fallback.

---

## 1. How to power Gemini - recommendation: the Gemini API, paid tier, small prepay

| Option | What I found (checked 17 Nov 2026) | Verdict |
|---|---|---|
| **Gemini CLI with Google Pro login** | Google stopped serving Gemini CLI for free, AI Pro and AI Ultra logins on **18 June 2026** (Google Developers Blog, 19 May 2026). | **Dead.** Cannot be used. |
| **Antigravity CLI (`agy`, the replacement) with Pro login** | Headless runs are allowed for your own *local* scripts. But a Google staff answer on the official forum says an MCP bridge that lets another AI agent call it is "an unauthorized client layer", and that the Pro quota is for direct use inside Antigravity. That is exactly what the mailbox would be. Users also report the Pro quota running out after a few prompts. | **No.** Breaks the terms for our use, could get the Google account blocked, and would eat the Pro quota you use by hand. |
| **Gemini API, free tier** | Free only for Flash and Flash-Lite models, no Pro models. Google says free-tier prompts **are used to improve Google's products**. | **No** for our tasks: task files are written by Claude (our rule: Claude's output must not become training data) and may hold project details. OK only for throw-away tests. |
| **Gemini API, paid tier** ✅ | Paid-tier data is not used for training. Pay per use, prepaid credit possible. Batch mode = half price. | **Use this.** |

**Prices (Google's pricing page, read 17 Nov 2026, per 1 million tokens, input / output):**
- Gemini 3.8 Flash: $0.75 / $3.75 until 31 Dec 2026, then **$1.50 / $7.50** from 1 Jan 2027.
- Gemini 3.1 Pro: $2 / $12 (prompts under 200k tokens).
- Gemini 4 Argon (flagship): $2 / $10 until 30 Nov 2026, then $4 / $20.
- Batch (answer within hours, not minutes): half of the above.
- "Thinking" tokens are billed as output. Google Search grounding (live web research) has its own price - **NOT VERIFIED yet, I check it in Step 4.**

**What it costs you in practice (my estimate):**
- A bulk-writing task like G-001 (77 help texts): about 20k tokens in, 30k out -> **~$0.15 on Flash, ~$0.40 on Pro.**
- A long research or first-draft-of-an-app task: about 100k in, 50k out on Pro -> **~$0.80.**
- 30 tasks a month: **about $5-15 a month.** Default caps below keep it under $15 even if something goes wrong.
- Model choice per task: Flash for bulk text, Pro for research and code drafts. Claude picks; you can override.

**Honest limit:** very deep research (like G-002, the Ahrefs study) is still better in the Gemini **app's** Deep Research, which
the API does not fully copy. For those few tasks we keep the manual route. Everything else goes through the mailbox.

---

## 2. The mailbox - how tasks and answers travel

```
Claude (claude.ai)                    Your server                              Google
  |  1. writes task file in claudemin repo (as today), pushes
  |  2. mailbox_post_task("G-003") ---->  mailbox app: saves the task, queue
  |                                        worker: git pull claudemin (read-only)
  |                                        builds prompt = GEMINI.md + task + context
  |                                        load guard OK? caps OK? privacy check OK?
  |                                        -------- calls Gemini API ----------->  Gemini
  |                                        <------- answer ----------------------
  |                                        saves answer + splits code into files
  |  3. mailbox_list / mailbox_get_answer <-
  |  4. Claude checks, commits to answers/<project>/, updates STATUS.md (as today)
```

- **Why the worker pulls the task from the repo:** Claude only sends the task ID (a few words), not the whole context. That
  saves Claude tokens. The claudemin repo stays the single record of every task and checked answer.
- **Connector tools Claude gets** (small, clear set):
  `mailbox_post_task` (ID, model, allow client data yes/no) · `mailbox_list` (status of all tasks) ·
  `mailbox_get_answer` (summary first, full text only when asked - saves tokens) · `mailbox_get_draft_files` (code drafts) ·
  `mailbox_status` (server load, today's spend, paused or running) · `mailbox_cancel`.
- **Gemini's first code drafts:** Gemini already answers in the GEMINI.md format (`File: path` + one code block per file).
  The worker cuts each block into a real file under `drafts/<task-id>/<path>`. Claude reads them through the connector,
  rewrites and tests them, then commits to the project repo. **The worker never runs, installs or copies draft code anywhere.**
- **Storage:** plain files in folders plus one small SQLite database (built into Python) for the queue. Easy to back up, easy
  to move to another server.
- **Status words** match STATUS.md: open -> doing -> answered. Claude then sets checked / used in the repo as today.

---

## 3. The load guard - never hurt the websites on the server

- **Before every job and every 30 seconds during it**, the app reads the server's own numbers (CPU busy %, RAM used %).
  If either is **above 60%**, it pauses. It resumes only when both stay **below 50% for 5 minutes** (so it doesn't flip on and off).
- **One job at a time.** A lock file makes a second job wait.
- The worker runs at the **lowest priority** (`nice`/`ionice`), so the websites always win.
- Honest note: the worker itself is light - it mostly waits for Google's answer. The guard matters most when the server is
  already busy, and it stays useful later if we add heavier local jobs.
- **Daily caps (safe defaults, editable in plain-English settings):**
  - max **1 million tokens per day**,
  - max **$1 per day** and **$15 per month**,
  - when a cap is reached: jobs wait until the next day, `mailbox_status` says why.
  - Spend is counted from Google's own token numbers on every answer. As a second safety net, you also set a spend limit in
    your Google billing account (Section 6).
- **Retries:** if Google says "too busy" or errors, wait 1, 2, 4, 8 ... minutes (max 30), 5 tries, then mark the task blocked.
- **Resumable:** progress saved after every step; after a server restart, unfinished jobs carry on where they stopped.
- **Log page:** one simple password-protected page: task list, status, tokens, cost, pauses. Logs keep IDs and numbers only,
  never the task text.

---

## 4. What stays private

- **Client website data never goes to Gemini by default.** Every task has `client data allowed = no` unless you say in chat
  "allow client data for G-NNN". Claude then sets it for that one task only, and it is written in the log.
- **Automatic check before sending:** the worker scans the prompt for website addresses not on your own list (smartupworld.com
  etc.), email addresses, phone numbers and anything that looks like a password or key. If it finds any and the task is not
  allowed -> the task is **blocked, nothing is sent**, and Claude is told what was found.
- **Keys and passwords** (Gemini API key, connector login) live only in one config file on the server, readable only by the app.
  Never in a repo, never in a task.
- **Paid tier only**, so Google does not train on what we send.
- The repo-read key for claudemin is read-only; the server can't change the repo.

---

## 5. Build order - small steps, one chat each

| Step | What | Model | Test before release |
|---|---|---|---|
| 1 | This plan | (done) | You approve |
| 2 | Mailbox app + queue + load guard + caps + log page (no Gemini yet, fake answers) | Sonnet 5.5 | Load guard pauses under a fake 70% load; caps stop a job; restart resumes |
| 3 | Claude connector (MCP over HTTPS, with login) | Sonnet 5.5 (the login part is the trickiest; if it fails twice, one Opus session) | Add it in claude.ai, post a fake task, read the fake answer |
| 4 | Gemini worker (API, model choice, draft-file splitting, privacy check) | Sonnet 5.5 | One tiny real call; a task with a client URL gets blocked |
| 5 | First real task end to end: G-001 (77 help texts) | Sonnet 5.5 | Answer arrives, Claude checks and commits it |
| 6 | Other projects (smartupworld-site, client-sites, new-apps) | Sonnet 5.5 | One task per project |

- Code rules: Python 3 standard library only (plus nothing, if possible), works on Python 3.6+, like SmartBot.
- Each step is small enough to fit one normal chat. Before each step I say if it fits your remaining usage.
- If the old SmartBot connector already has a working login, Step 3 copies that approach to save work.

---

## 6. What only you can do (kept to the minimum)

1. **Server:** tell me RAM, OS and whether you can log in (I ask you next). Then give me SSH or Plesk access once; I save it.
2. **Gemini API key:** in Google AI Studio, create a key on a project **with billing turned on**, add a small prepaid credit
   (e.g. $10), and set a budget alert / spend limit. I'll send exact clicks when we reach Step 4. (Note: prepaid credit expires
   after 12 months and stops the key when it hits $0 - that is a good safety net.)
3. **DNS:** one record, e.g. `mailbox.smartupworld.com` pointing to the server's IP (I'll give the exact line).
4. **GitHub:** add one read-only "deploy key" to the claudemin repo (I'll give the key and the 3 clicks).
5. **claude.ai:** Settings -> Connectors -> Add custom connector -> paste the URL I give -> log in. One time.

Everything else (install, HTTPS certificate in Plesk, settings, tests) I do.

---

## Sources (read 17 Nov 2026)
- Google Developers Blog, "Transitioning Gemini CLI to Antigravity CLI", 19 May 2026 - https://developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/
- Google AI forum, staff answer on agy through an MCP bridge - https://discuss.ai.google.dev/t/is-using-the-official-agy-cli-through-a-local-mcp-server-with-third-party-ai-agents-permitted/184829
- Antigravity plans (Pro quota shape) - https://antigravity.google/docs/plans
- Gemini API pricing - https://ai.google.dev/gemini-api/docs/pricing
- Claude help: custom connectors using remote MCP - https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp
