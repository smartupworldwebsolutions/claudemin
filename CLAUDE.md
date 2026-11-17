# CLAUDE - your side of the Claude <-> Gemini bridge (any project, any chat)

Mahmud uses Gemini Pro to save his Claude budget. Gemini: long research, bulk writing, first code drafts. Claude: all code that
runs, checking Gemini's work, design decisions. Gemini can only READ this repo (one repo per Gemini chat, as a frozen copy).

## Every chat that touches a project in PROJECTS.md
1. Attach this repo (smartupworldwebsolutions/claudemin, read is enough unless you will change the board) and look at STATUS.md.
2. **Answer waiting** (row "answered", or Mahmud says "Gemini answer G-NNN is saved"):
   - read it from his PC: SmartBot connector `smartbot_files` read `bridge/inbox/G-NNN-answer.md` (or the file he attached);
   - check it: facts against the named sources (spot-check the important ones), CSV columns/rows, code against the project's rules;
   - commit it to `answers/<project>/G-NNN-answer.md` here (remove anything secret first), set the row to checked (what was
     wrong / what you kept) and later used (commit in the project repo).
3. **New long research, bulk text, or a draft that needs much back-and-forth** -> don't spend Claude tokens on it: add a row
   `G-NNN | <project> | Gemini | open`, write `tasks/<project>/G-NNN-<name>.md` with: goal, what the answer is for, exact
   questions, sources to use, answer format (files, columns), and COPY into `tasks/<project>/context/` every project file Gemini
   needs (Gemini cannot open the project repo in the same chat). Update "Last updated by Claude", push, and give Mahmud the one
   prompt from STATUS.md.
4. **Gemini code** is never installed as it is: review, rewrite to the project's rules, test, then commit in the project repo.
5. Never put passwords, keys, tokens, server logins or client data in this repo.

## Keep it tidy
- One task = one file; IDs never reused; finished rows stay (history). Old context copies can be deleted when the task is used.
- New project -> add it to PROJECTS.md (name, what it is, where its code/notes live, rules Gemini must follow for it).
