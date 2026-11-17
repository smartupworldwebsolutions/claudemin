#!/bin/sh
# Usage: ./make_pack.sh G-003   -> writes packs/G-003-pack.md (GEMINI.md + task file + its context files)
# Claude runs this and sends the pack to Mahmud, who attaches it to a NEW Gemini chat.
id="$1"; [ -n "$id" ] || { echo "usage: $0 G-NNN"; exit 1; }
t=$(ls tasks/*/"$id"-*.md 2>/dev/null | head -1); [ -n "$t" ] || { echo "no task file for $id"; exit 1; }
mkdir -p packs; out="packs/$id-pack.md"
{ echo "# START HERE (Gemini)"; echo "Read this whole file, then do the task at the bottom. Follow part 1 (GEMINI.md) exactly."
  echo; echo "## OUTPUT RULES (most important)"
  echo "- Do NOT chat or explain. Your whole reply is the finished document, nothing else."
  echo "- Put it in a Canvas / document if you can (so it can be downloaded or copied as one piece). If not, put each part inside ONE markdown code block (three backticks + markdown) so I can copy it with one click."
  echo "- Long answer: split into parts, each starting with PART n of N. Stop after each part and wait for me to say next."
  echo "- Use clear headings (#, ##), tables and bullet lists in markdown. No filler, no intro, no summary of what you did."
  for f in GEMINI.md "$t" $(ls "$(dirname "$t")"/context/* 2>/dev/null); do echo; echo "=================== FILE: $f ==================="; cat "$f"; done; } > "$out"
echo "$out"
