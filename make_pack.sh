#!/bin/sh
# Usage: ./make_pack.sh G-003   -> writes packs/G-003-pack.md (GEMINI.md + task file + its context files)
# Claude runs this and sends the pack to Mahmud, who attaches it to a NEW Gemini chat.
id="$1"; [ -n "$id" ] || { echo "usage: $0 G-NNN"; exit 1; }
t=$(ls tasks/*/"$id"-*.md 2>/dev/null | head -1); [ -n "$t" ] || { echo "no task file for $id"; exit 1; }
mkdir -p packs; out="packs/$id-pack.md"
{ echo "# START HERE (Gemini)"; echo "Read this whole file, then do the task at the bottom. Follow part 1 (GEMINI.md) exactly."
  for f in GEMINI.md "$t" $(ls "$(dirname "$t")"/context/* 2>/dev/null); do echo; echo "=================== FILE: $f ==================="; cat "$f"; done; } > "$out"
echo "$out"
