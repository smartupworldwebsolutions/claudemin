# G-002 - deep research: how Ahrefs Site Audit's Page explorer and URL details panel work, exactly

**What it is for:** SmartBot is getting the same kind of issue list + right-side page panel (plan:
`tasks/smartbot/context/AHREFS_ISSUE_LIST_DESIGN.md` (a copy from the SmartBot repo), read "RESEARCH" and "THE BUILD" first - do not repeat what is already there; fill the gaps).
Claude builds it from your answer, so precision matters more than length. Use Ahrefs Academy, help.ahrefs.com (Site Audit
collections), docs.ahrefs.com (API "site-audit" endpoints, Looker Studio "Site Audit fields"), Ahrefs blog + YouTube videos
(describe what is visible in the video, with the time stamp), and reviews/tutorials from 2024-2026. Mark anything you could not
confirm "NOT VERIFIED".

**Answer these, each under its own heading:**
1. **Filter presets** in Page explorer: the full list per tab (All URLs, Pages, Resources, Content, Links, Redirects,
   Indexability, SEO metrics, AI Discoverability ...) - the name of every preset and the rule behind it.
2. **Advanced filter**: every condition word offered (is, contains, exists, regex, changed, changed to, dropped by % ...), for
   which field types (text, number, yes/no, list), how groups and AND/OR look, "previous crawl" switch, saving a filter as a
   segment or a custom issue.
3. **Default columns** of Page explorer and of Link explorer, and how the Columns picker works (search, groups, order, saved?).
4. **"Show changes"**: what a changed cell looks like, the New / Lost / No change filter, which fields can be compared.
5. **URL details panel, tab by tab** (Overview, Issues, All/Href/Redirect/Canonical inlinks, Outlinks internal/external,
   Hreflangs, Duplicates, Image/CSS/JavaScript resources, Structured data, View source): the columns of each table, the filters
   and buttons on each tab, what the counts mean, empty states, and what "Recrawl", "Submit to IndexNow" and "Export" do there.
6. **Issues**: how one issue is shown (title, severity colour, "Why and how to fix" text structure, number of affected URLs,
   change since last crawl), how severity is changed per project, how a custom issue is made from a filter.
7. **The complete current issue list** (aim for all 170+): name, severity (error / warning / notice), category. Name the
   source for each block; mark "NOT VERIFIED" where the severity is a guess.
8. **Things competitors do better** (Screaming Frog SEO Spider, Sitebulb, Semrush Site Audit) for the same list + panel, that
   SmartBot could add - max 10, each with a source.

**Answer format:** as in bridge/GEMINI.md section 4. Put item 7 also as a CSV block (`File: G-002-ahrefs-issues.csv`, header
`name,severity,category,source`).
