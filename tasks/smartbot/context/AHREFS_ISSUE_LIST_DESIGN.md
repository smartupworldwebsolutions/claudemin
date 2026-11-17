# Ahrefs-style issue lists + page side panel (owner request 17 Nov 2026) - NEXT JOB after LAYOUT-1

Source: owner's screenshots (Ahrefs "Orphan page", 370 results; Ahrefs page side panel; SmartBot /orphans today) and the
saved HTML of Ahrefs Site Audit > Page explorer (5,015 results). The saved HTML holds only what is on screen; dropdown
contents load on click, so their exact options are NOT in it (below = what is visible + what the screenshots show).

## What is wrong in SmartBot today (/orphans screenshot)
- Every row is open (suggested links listed under each page) -> one endless page, no paging, hard to scan.
- No count line, no column choice, no export bar, no filters.
- Clicking a page address leaves SmartBot and opens the live website.

## What Ahrefs does (build the same, in SmartBot's shell)
1. **Head**: "Issues / <issue name>" + "Why and how to fix" (help popover), right side actions (Submit to IndexNow,
   Create issue, Fix with ...). For SmartBot: "Why and how to fix", "Make fix drafts", "Export".
2. **Filter tabs** (one row): All URLs | Pages | Resources | Content | Links | Redirects | Indexability | SEO metrics |
   AI Discoverability - each a dropdown of ready filters. Then a search box "Word or phrase" with a field picker (URL,
   title ...) and "Advanced filter" (column + condition + value rows).
3. **Result bar**: "370 results" left; right: Patches, "Changes: Don't show" (compare with the previous crawl: new / fixed /
   changed), Columns (pick + order columns, saved per person), AI · API, Export (CSV).
4. **Table**: one compact row per page. Columns: PR (circle score), type icon, title (cut) + address under it with a
   magnifier icon, Organic traffic, HTTP status (green badge), Content type, Depth, Is indexable, No. of inlinks,
   Referenced in sitemaps, First found at ... Sort by clicking a column head.
5. **Paging**: first 50 rows, then "Show more" + "Showing 50 of 370" (adds the next 50 in place; server-side LIMIT/OFFSET).
6. **Side panel** (click a row / magnifier): slides in from the RIGHT over about half the screen, list stays behind it,
   X closes, URL keeps ?page=ID so it can be shared. Inside:
   - head: type icon, page title, address (the small arrow icon is the ONLY link that opens the live site), Export
   - left tabs with counts: Overview, Issues (red count), All inlinks, Href / Redirect / Canonical inlinks,
     Outlinks internal / external, Hreflangs, Duplicates, Image / CSS / JavaScript resources, Structured data, View source
   - Overview: PR ring, Errors / Warnings / Notices counts, Crawled time + "Recrawl" button;
     sections (fold open/closed): URL info (type, internal, full URL, HTTP status, first found at, content type, depth,
     indexable, canonical + "self-reference" badge, meta robots, X-Robots-Tag, present in sitemap), HTTP headers,
     Performance (time to first byte, load time, size, compression), Content (title, meta description "Missing" badge,
     H1, H2 list ...)
   - every page address inside the panel opens THAT page's panel in SmartBot, never the live website.

## RESEARCH 17 Nov 2026 (owner: "you can't build it blindly") - what Ahrefs really has
Sources: ahrefs.com/academy (Site Audit > Page explorer, Link explorer, Overview), ahrefs.com/site-audit, ahrefs.com/blog/new-site-audit-features,
help.ahrefs.com Issues collection (54 issue articles: "What triggers / Why it matters / How to fix"), docs.ahrefs.com Looker Studio
"Site Audit fields" (the full Page explorer field list), trendlineseo.com Ahrefs issue table (151 issue names), owner's 3 screenshots.
- Ahrefs claims 170+ predefined issues, 250+ data points per page, 40+ filter presets, and "the industry's most complete URL details panel".
- Errors (red) lower the Health score; warnings (yellow) and notices (blue) do not. Severity can be changed per project; own issues can be made from a filter.
- Export at 3 levels: all issues / pages of one issue / all issues of one page (from the panel).
- Page explorer: preset dropdowns + "Word or phrase" search with field picker + Advanced filter (rule GROUPS joined by AND/OR, any of 250 fields,
  conditions incl. "changed", "changed to", "dropped by at least %") + "previous crawl" switch (filter by the value in the last crawl) +
  "Show changes" (every column shows old -> new; rows New / Lost / No change) + Columns picker + Export. Hovering a field name shows a hint.
- Link explorer = the same table, one row per LINK (source, anchor, target, target status, target no-crawl reason, dofollow/nofollow, type).
- URL details panel (screens 1+3): opens on the right over the list. Head: type icon, title, URL (small arrow = only way to the live site),
  "Submit to IndexNow", "Export", X. LEFT MENU with counts, in this order:
  Overview | Issues (count badge) | All inlinks, Href inlinks, Redirect inlinks, Canonical inlinks | Outlinks internal, Outlinks external |
  Hreflangs | Duplicates | Image resources, CSS resources, JavaScript resources | Structured data | View source.
  * Overview: PR ring, Errors / Warnings / Notices counts, Crawled time + Recrawl button; folding sections URL info (type, internal, full URL,
    HTTP status badge, first found at, content type, depth, is indexable, canonical + "Self-reference" badge, meta robots, X-Robots-Tag
    ("Missing" in grey), present in sitemap = the sitemap file), HTTP headers (all response headers), Performance (TTFB, load time, size,
    compression), Content (title, meta description with red "Missing", H1, numbered H2 list ...), also social tags.
  * Issues: every issue of this page, grouped by severity, each with "Why and how to fix", export of this page's issues.
  * Inlink tabs: table Source URL | Anchor | Dofollow tick; "Follow" filter (all/dofollow/nofollow), search box, "Open in Link explorer".
  * Outlinks: target URL, anchor, target HTTP status, dofollow.
  * Hreflangs: the whole hreflang cluster drawn as a link network; broken pages/links in red.
  * Duplicates: the pages sharing this page's content / title / description / H1 (groups).
  * Resources: each image/CSS/JS file with status, size, (images) alt text.
  * Structured data: each JSON-LD/microdata item, its type and validation errors (schema.org + Google rules).
  * View source: Raw HTML / Rendered HTML / Text, a crawl-date dropdown -> diff against an older crawl (removed red, added green), search.

## What SmartBot has today vs needs (from the code, 17 Nov 2026)
- Per page (da_pages): http, ms, bytes, title(+len,hash), desc_len/hash (NOT the text), h1, h1_n, h2_n (NOT the list), words, text_ratio,
  readability, canonical(+count, canon_state), robots, xrobots, indexable, hreflang_n (NOT the list), schema_types (NOT the items), og,
  twitter, viewport, lang, imgs/noalt/nodim (counts only), links_out/ext/nofollow/in, broken_out, redir_out, redirect_to/hops/loop,
  compressed, cache_ctl, hsts, content_hash, simhash, click_depth, pr, dup_* counts, near_dup, issues (codes). da_links: src, dst, anchor,
  nofollow. da_found: first_seen, inlinks. Plus gsc_pages/gsc_queries (Google clicks), cwv_page (LCP/CLS/INP), oc_fixes (what worked).
- 56 issue checks in plugins/deep_audit.py ISSUES (critical/warning/notice + why + how). Ahrefs ~150-170.
- MISSING to show the panel fully: stored HTML snapshot (raw + text, last 2-3 crawls, zlib-compressed, size cap setting), all response
  headers, TTFB separate from load time, meta description text, H2 list, OG/Twitter values, hreflang list, JSON-LD items, resources per page
  (url, kind, status, bytes, alt), sitemap file per URL, link type (href / redirect / canonical / hreflang / img), per-run history of key
  fields (for "Changes" and "previous crawl"), external link status.
- No JavaScript rendering in SmartBot: "Rendered HTML" = say honestly "not rendered (raw HTML only)" unless a renderer is added later.

## THE BUILD - Opus 5.5, one phase per chat, in this order
### Phase 1 - data (deep_audit.py + new da_* tables, bot.add_column, keep all data)
- da_snap (project_id, url_hash, run_id, raw MEDIUMBLOB zlib, text MEDIUMBLOB zlib, headers TEXT JSON, ttfb_ms, load_ms) - keep last N runs
  (setting, default 3) + a total-size cap; da_res (page hash, url, kind img/css/js/font, http, bytes, alt, protocol);
  da_hist (run_id, url_hash, http, indexable, title_hash, desc_hash, h1, words, links_in, canonical, bytes, ms) for Changes.
- da_pages new columns: desc TEXT, h2_list TEXT(JSON), og_json, tw_json, hreflang_json, schema_json, sitemap_url, ttfb, link types in da_links
  (kind: href/redirect/canonical/hreflang/img/css/js; plus target status cached).
- New checks to reach Ahrefs' list where SmartBot can measure it honestly (no invented numbers): broken/redirected/oversized/HTTP image-CSS-JS
  (page has broken X, X redirects, X file too large, HTTPS page links to HTTP X), canonical HTTP<->HTTPS / to 4xx / 5xx / redirect /
  non-canonical-as-canonical / canonical has no inlinks, noindex+nofollow combinations, noindex in HTML AND header, nofollow page,
  redirect chain too long, broken redirect, HTTPS->HTTP redirect, meta refresh, 3xx/4xx/5xx/non-canonical/noindex in sitemap, indexable page
  not in sitemap, page in multiple sitemaps, timed out from sitemap, nofollow incoming only, nofollow+dofollow incoming, no outgoing links,
  nofollow outgoing internal, redirected page has no inlinks, multiple titles / descriptions, hreflang (invalid, missing reciprocal, to
  broken/redirect/non-canonical, self missing, x-default missing, lang mismatch, same language twice), OG URL vs canonical, OG/Twitter
  missing, structured data (JSON parse error, missing required property for Google rich results types, invalid date, image missing),
  render-blocking JS/CSS in head, LCP image lazy-loaded, changed issues (title/H1/description/word count changed, indexable became
  non-indexable), and with Google data (gsc_pages): 3xx/4xx/5xx/noindex/non-canonical page receives organic traffic, clicks dropped.
  Every new check: severity, category, plain "why it matters" + "how to fix" (same tuple as ISSUES), and a test.
### Phase 2 - the shared table (core/ui_table.py, used by every list)
- Filter tabs with presets (All URLs, Pages, Resources, Content, Links, Redirects, Indexability, SEO metrics, Search Console) - 40+ presets;
  "Word or phrase" + field picker; Advanced filter (groups, AND/OR, every column, is/isn't/contains/regex/>/</exists/changed/changed to/
  dropped by %); "Previous audit" switch; "Show changes" (old -> new in cells, New/Lost/No change filter); Columns picker (saved per
  person, hint on hover); sort on any column; 50 rows then "Show more"; count line; Export CSV (all rows, background job if huge);
  row tick boxes + bulk actions (Recheck pages, Make fix drafts, Export). All server-side SQL with %s args, never 1000s of rows to the browser.
- Page explorer (/crawl becomes it) and Link explorer (/link-explorer) are this table on da_pages / da_links.
### Phase 3 - the URL details panel (/page-panel?p=ID&u=HASH&tab=..., fragment loaded into a right slide-in panel; ?panel= in the address)
- Same left menu and counts as Ahrefs (above) + SmartBot extras at the end: Google (clicks, impressions, position, top queries),
  What worked (oc_fixes for this page and measured effect), Your rating (Needs work / Fine - teaches SmartBot), Fix drafts.
- Head: Recheck now (one-page re-audit job, honest "queued"), Export (this page's issues CSV), Make fix drafts, live-site arrow.
- Every URL inside the panel opens THAT page's panel; Esc / X closes; up/down arrows step through the list behind it.
### Phase 4 - switch every list to it
- Website overview "Top pages to fix", Fix first, Crawl issues (each issue -> Page explorer filtered to it, "Why and how to fix" popover),
  All issues, Orphans, Broken links, Duplicates, Pages, Redirects & canonicals ... a page title/URL ALWAYS opens the panel (R7).
- Tests: per phase (fake db harness + test_layout_consistency.py) + screenshots of the list and the panel tabs.
- Cheap help: the plain "why it matters / how to fix" texts for the ~100 new checks can be drafted in Gemini (owner's Gemini Pro) from the
  Ahrefs help-article titles; Claude only checks and pastes them.

## How to build it in SmartBot (one shared part, not per page)
- New core part `core/ui_table.py` (or extend core/ui.py): table with column picker, sort, search, filter tabs,
  "Show more" paging, export CSV - one function every issue page calls with its rows query + column list.
- New plugin page `/page-panel?id=N` (JSON/HTML fragment) + one small script in UI_JS that opens it as the right panel.
  Data from tables that already exist (pages, da_pages, da_links, health, technical results) - read the schema first.
- Then switch the issue pages to it one by one: /orphans first (owner's example), then /site-audit (All issues), /pages,
  /broken-links, /duplicates ...
- Size: big cross-cutting UI work -> Opus 5.5, 2-3 chats: (1) table part + /orphans, (2) side panel, (3) other pages.

## Notes from the owner's 17 Nov screenshots: Ahrefs Dashboard + Site Audit list (navigation rule)
**Ahrefs Dashboard** (app.ahrefs.com/dashboard): top bar = tools (Dashboard, Brand Radar, Site Explorer, Site Audit ...).
Left bar = NOT the tools again, but the project navigator: "+ Create" (with a drop-down), a settings cog, Search, then
Projects / Portfolios / Reports / Keyword lists / Starred, then Folders (+ add). Content: tabs Overview | Web Analytics |
Rank Tracker | GSC Insights, right side "Trends: Last 30 days" and "Newest first". One CARD per project: thumbnail, name +
verified tick, domain with a drop-down (*.domain/*), right side Basic badge / Shared / star / menu. Card metrics: Health
Score ring + AI Discoverability ring, AI responses (AI Overviews / AI Mode / ChatGPT counts with +/- change), DR,
Referring domains with a small chart, Total visitors ("Start monitoring" if not set up), Est. organic traffic with change
and a chart, Organic keywords, Tracked keywords (or "Not available on a Free plan").
**Ahrefs Site Audit list** (app.ahrefs.com/site-audit): no left bar; "+ New project", "My projects 3" filter, "Find project"
search, right "Bulk project settings", "Issue settings". ONE TABLE ROW per project, different columns: Project (thumbnail,
name, domain), Health score ring, AI score ring (Beta), Last crawl (Yesterday + time), Status (green "Completed"), URLs
crawled, Internal URLs having errors, Scheduled (next run), Always-on audit (Start), plan badge, row menu.
**The rule taken from it:** the same websites appear in two places but each place shows DIFFERENT information in a
DIFFERENT look (cards with business numbers vs. an audit table). A link is never just copied into a second menu.

## Built 17 Nov 2026 (LAYOUT-2)
- Top bar = SmartBot's own pages, identical on every page (so nothing becomes unreachable when the left bar changes).
- Left bar on all-websites pages = websites navigator: "Add a website" (opens the add form), Views (Site audit - all
  websites, Need attention (N), Paused (N)), "Your websites" with a health dot + score each, a search box when > 6.
  Run now / Activity / Requests are no longer repeated there (they stay in the top bar).
- Left bar on a website's pages = that website's menu; first row "< All websites" goes to the Site audit list.
- Dashboard: tab Overview = a card per website (health ring, pages audited, need work / broken, uptime + response time,
  Search Console clicks 28 days vs the 28 before, competitors); tab Site audit = a table (health ring, last audit, status
  Running x% / Waiting / Completed / Never run / Paused, pages checked, pages with critical problems, Start, Open audit).
- tests/test_layout_consistency.py fails if any page has a link in the top bar AND the left bar, or a bar lists a link twice.
- STILL TO BUILD (next chats): the issue-list table + right side panel above; AI score and thumbnails are not built.
