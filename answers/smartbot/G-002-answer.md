BRIDGE-ANSWER
task: G-002
project: smartbot
file: G-002-answer.md
status: partly done
summary: Deep-dive specification of Ahrefs Site Audit Page Explorer, Advanced Filters, Columns, Change Tracking, URL Details Panel, Issue Mechanics, Issue Catalog, and Competitor Enhancements.
questions for Claude: Should the issue CSV in section 7 map Ahrefs issue names directly to existing SmartBot `deep_audit.py` issue codes where an overlap exists, or remain purely a reference catalog of Ahrefs' checks?

# G-002: Ahrefs Site Audit Page Explorer & URL Details Panel Deep Research

## 1. Filter Presets in Page Explorer

The top filter bar in Ahrefs Site Audit > Page explorer categorizes pre-built filter segments into dropdown tabs. Selecting a preset populates the Advanced Filter query builder automatically.

* **All URLs**
  * **All URLs:** `URL` `exists` (shows every crawled, uncrawled, and resource URL discovered).
  * **Internal URLs:** `Is internal` `is` `Yes` (filters out external domains).
  * **External URLs:** `Is internal` `is` `No` (shows only outbound external targets).
  * **Crawled URLs:** `Is crawled` `is` `Yes` (URLs where Ahrefsbot successfully fetched headers/body).
  * **Uncrawled URLs:** `Is crawled` `is` `No` (URLs blocked by robots.txt, excluded by settings, or queued/timed out).
* **Pages**
  * **All HTML pages:** `Content type` `contains` `text/html` AND `Is internal` `is` `Yes`.
  * **200 OK pages:** `Content type` `contains` `text/html` AND `HTTP status code` `is` `200` AND `Is internal` `is` `Yes`.
  * **Non-200 pages:** `Content type` `contains` `text/html` AND `HTTP status code` `is not` `200` AND `Is internal` `is` `Yes`.
  * **4xx pages:** `Content type` `contains` `text/html` AND `HTTP status code` `>=` `400` AND `HTTP status code` `<` `500` AND `Is internal` `is` `Yes`.
  * **5xx pages:** `Content type` `contains` `text/html` AND `HTTP status code` `>=` `500` AND `Is internal` `is` `Yes`.
  * **Paginated pages:** `Is paginated` `is` `Yes` (pages containing `rel="next"` or `rel="prev"`).
  * **AMP pages:** `Is AMP` `is` `Yes` (pages with AMP HTML markers or `rel="amphtml"`).
* **Resources**
  * **All resources:** `Is internal` `is` `Yes` AND `Content type` `does not contain` `text/html`.
  * **Images:** `Resource type` `is` `Image` (or `Content type` `starts with` `image/`).
  * **JavaScript:** `Resource type` `is` `JavaScript`.
  * **CSS:** `Resource type` `is` `CSS`.
  * **Fonts:** `Resource type` `is` `Font` (NOT VERIFIED - exact preset name in UI may be grouped under "Other resources").
  * **Broken resources:** `Resource type` `is not` `HTML` AND `HTTP status code` `>=` `400`.
* **Content**
  * **Missing title:** `Title` `is empty` AND `Is indexable` `is` `Yes`.
  * **Duplicate title:** `No. of pages with same title` `>` `1` AND `Is indexable` `is` `Yes`.
  * **Missing meta description:** `Meta description` `is empty` AND `Is indexable` `is` `Yes`.
  * **Duplicate meta description:** `No. of pages with same meta description` `>` `1` AND `Is indexable` `is` `Yes`.
  * **Missing H1:** `H1` `is empty` AND `Is indexable` `is` `Yes`.
  * **Multiple H1 tags:** `No. of H1 tags` `>` `1` AND `Is indexable` `is` `Yes`.
  * **Low word count:** `Word count` `<` `300` (threshold varies by project setting, default ~200-300 words) AND `Is indexable` `is` `Yes`.
  * **Exact duplicates:** `No. of exact duplicates` `>` `1`.
  * **Near duplicates:** `No. of near duplicates` `>` `1`.
* **Links**
  * **Orphan pages:** `No. of internal inlinks` `is` `0` AND `Is indexable` `is` `Yes` (discovered via sitemap, backlinks, or GSC, not internal crawl paths).
  * **Pages with no outgoing links (Dead-end pages):** `No. of internal outlinks` `is` `0` AND `Is indexable` `is` `Yes`.
  * **Pages with only one internal inlink:** `No. of internal inlinks` `is` `1` AND `Is indexable` `is` `Yes`.
  * **Pages with broken outlinks:** `No. of broken outlinks` `>` `0`.
  * **Pages with redirected outlinks:** `No. of redirect outlinks` `>` `0`.
  * **Deep pages (Depth > 3):** `Depth` `>` `3` AND `Is indexable` `is` `Yes`.
* **Redirects**
  * **All redirects:** `HTTP status code` `>=` `300` AND `HTTP status code` `<` `400` AND `Is internal` `is` `Yes`.
  * **301 redirects:** `HTTP status code` `is` `301`.
  * **302 / temporary redirects:** `HTTP status code` `is one of` `302, 303, 307`.
  * **Redirect chains:** `No. of redirects in chain` `>` `1`.
  * **Redirect loops:** `Is redirect loop` `is` `Yes`.
  * **Broken redirects:** `Final redirect HTTP status` `>=` `400`.
* **Indexability**
  * **Indexable pages:** `Is indexable` `is` `Yes`.
  * **Non-indexable pages:** `Is indexable` `is` `No` AND `Is internal` `is` `Yes`.
  * **Noindex pages:** `Meta robots` `contains` `noindex` OR `X-Robots-Tag` `contains` `noindex`.
  * **Canonicalized pages:** `Canonical URL` `is not empty` AND `Is self-canonical` `is` `No`.
  * **Self-canonicalized pages:** `Is self-canonical` `is` `Yes`.
  * **Missing canonical:** `Canonical URL` `is empty` AND `Is indexable` `is` `Yes`.
  * **Blocked by robots.txt:** `Robots.txt status` `is` `Disallowed`.
  * **Indexable pages not in sitemap:** `Is indexable` `is` `Yes` AND `Is in sitemap` `is` `No`.
  * **Non-indexable pages in sitemap:** `Is indexable` `is` `No` AND `Is in sitemap` `is` `Yes`.
* **SEO metrics**
  * **Pages with organic traffic:** `Organic traffic` `>` `0`.
  * **Non-indexable pages with organic traffic:** `Is indexable` `is` `No` AND `Organic traffic` `>` `0`.
  * **Pages with referring domains:** `Referring domains` `>` `0`.
  * **4xx pages with backlinks / referring domains:** `HTTP status code` `>=` `400` AND `HTTP status code` `<` `500` AND `Referring domains` `>` `0`.
  * **High URL Rating (UR) pages:** `URL Rating` `>=` `20` (NOT VERIFIED - exact threshold).
* **AI Discoverability** (Introduced in Ahrefs Site Audit 2025/2026 updates)
  * **Blocked from AI crawlers (GPTBot / ClaudeBot / Google-Extended):** `AI crawler access` `is` `Blocked` (NOT VERIFIED - exact underlying field structure in Ahrefs).
  * **Allowed for AI crawlers:** `AI crawler access` `is` `Allowed` (NOT VERIFIED).
  * **Missing llms.txt reference / schema readiness:** (NOT VERIFIED - exact presets under this tab).

*(Sources: Ahrefs Help Center "Page Explorer" & "Filter Presets in Site Audit", Ahrefs Academy "Site Audit" course, Ahrefs Blog product updates 2024-2026, accessed Nov 2026)*

---

## 2. Advanced Filter Mechanics

Clicking **Advanced filter** expands a structured query builder below the preset bar.

### Condition Operators by Field Type
* **Text / String fields** (URL, Title, H1, Meta description, Canonical URL, Content type, Headers):
  * `is` / `is not` (exact case-insensitive match)
  * `contains` / `does not contain`
  * `starts with` / `ends with`
  * `matches regex` / `does not match regex` (RE2 syntax)
  * `is empty` / `is not empty` (exists / does not exist)
  * `is one of` / `is not one of` (comma/newline separated list)
* **Numeric fields** (HTTP status code, Word count, Depth, Inlinks, Outlinks, Page size, TTFB, Load time, Organic traffic, PR/UR):
  * `=` (is) / `!=` (is not)
  * `>` (greater than) / `>=` (greater than or equal to)
  * `<` (less than) / `<=` (less than or equal to)
  * `between` (inclusive range)
  * `is empty` / `is not empty`
* **Boolean / Yes-No fields** (Is indexable, Is internal, Is crawled, Is in sitemap, Is self-canonical, Is redirect loop):
  * `is` (`Yes` / `No`)
* **Date / Timestamp fields** (First found at, Crawled at, Last modified):
  * `is` / `before` / `after` / `between`
  * `in the last X days`
* **Historical / Crawl-Comparison Operators** (Available on tracked fields when a previous crawl exists):
  * `changed` (value in current crawl != value in previous crawl)
  * `did not change` (value in current crawl == value in previous crawl)
  * `changed to` (current value == X AND previous value != X)
  * `changed from` (previous value == X AND current value != X)
  * `increased` / `decreased` (numeric fields)
  * `increased by at least` / `decreased by at least` (absolute value or `%` percentage toggle, e.g., `Word count` `decreased by at least` `20%` or `Organic traffic` `dropped by at least` `50%`).

### Logic Groups & Nesting
* **Structure:** Rules are arranged inside rectangular **Rule Groups**.
* **Within a group:** Rules are joined by a uniform operator toggle (`AND` / `OR`) at the left edge of the group.
* **Between groups:** Clicking **+ Add group** creates a sibling group block joined to the previous group by a top-level `AND` / `OR` toggle. (Ahrefs supports 2 levels: top-level groups containing flat lists of rules, avoiding arbitrary deep recursion while allowing `(A OR B) AND (C OR D)` logic).

### "Previous crawl" Switch
* Located inside the Advanced Filter bar (toggle switch labeled **Previous crawl** or **Compare with previous crawl**).
* When toggled ON for a specific rule (or globally in the filter bar), the condition evaluates against the URL's stored value from the **immediately preceding completed crawl** rather than the current crawl (e.g., `Previous crawl: Is indexable is Yes` AND `Current crawl: Is indexable is No`).

### Saving Filters (Segments vs. Custom Issues)
* **Saved Filters (Segments):** Clicking **Save** in the filter bar saves the query under a custom name in a "Saved filters" dropdown for quick re-use without affecting the project's Health Score.
* **Create Issue (Custom Issue):** Clicking **Create issue** (button in the top-right action bar next to Export) converts the active Advanced Filter query into a permanent custom audit rule. The modal asks for:
  1. **Issue name** (required)
  2. **Severity** (`Error`, `Warning`, or `Notice`)
  3. **Description / How to fix** (optional rich text note)
  * Once saved, Ahrefs evaluates this filter on every future crawl, counts matching URLs in the All Issues report, and factors it into the Health Score if set to `Error`.

*(Sources: Ahrefs Help Center "How to use Advanced Filters in Site Audit", "How to create custom issues in Site Audit", accessed Nov 2026)*

---

## 3. Default Columns & Columns Picker

### Page Explorer Default Columns
When opening Page Explorer without a specific issue filter, Ahrefs displays these default columns in order:
1. **URL** (Sticky left column: displays page favicon/type icon, truncated `<title>` on line 1, full URL path on line 2, plus hover icons for URL Details Panel and external open)
2. **PR** (Internal PageRank / URL Rating circle indicator, 0–100 scale)
3. **Organic traffic** (Estimated monthly organic search visits from Ahrefs database)
4. **HTTP status code** (Color-coded pill: green `200`, yellow `3xx`, red `4xx`/`5xx`)
5. **Content type** (e.g., `text/html; charset=UTF-8`)
6. **Depth** (Click depth from seed/homepage, integer `0`, `1`, `2`...)
7. **Is indexable** (`Yes` green text / `No` red text)
8. **No. of inlinks** (Count of internal incoming links, clickable to open Inlinks tab)
9. **Referenced in sitemaps** (`Yes` / `No` or sitemap URL count)
10. **First found at** (Timestamp when Ahrefsbot first discovered the URL)

*(Note: When entering Page Explorer from a specific issue, Ahrefs dynamically injects the issue's relevant columns—for example, `Title` and `Title length` for title issues, or `Canonical URL` for canonical issues).*

### Link Explorer Default Columns
1. **Source URL** (Page containing the link, with title + URL)
2. **Anchor** (Link anchor text, or `[Image]` / `[No text]` badge)
3. **Target URL** (Destination URL)
4. **Target HTTP status** (`200`, `301`, `404`, etc.)
5. **Target no-crawl reason** (e.g., `Blocked by robots.txt`, `External`, or `-`)
6. **Link type** (`Href`, `Redirect`, `Canonical`, `Hreflang`, `Image`, `Script`, `Stylesheet`)
7. **Dofollow / Nofollow** (`Dofollow` vs `Nofollow` / `UGC` / `Sponsored` badges)
8. **Is internal** (`Yes` / `No`)

### How the Columns Picker Works
* **Trigger:** Clicking the **Columns** button on the right side of the result bar opens a two-pane modal or wide popover.
* **Left Pane (Available Fields):**
  * Search input at the top (`Search columns...`) that filters fields live as you type.
  * Categorized accordion groups matching the data model: *URL info, HTTP & Crawl, Content, HTML tags, Links, Redirects, Indexability, Canonical, Hreflang, Sitemaps, Images & Resources, Structured data, Social tags (OG/Twitter), Performance, SEO Metrics, Changes*.
  * Hovering over any field name displays a tooltip explaining the metric and how Ahrefs calculates it.
  * Checkboxes next to each field to add/remove.
* **Right Pane (Selected Columns):**
  * Lists currently active columns in display order.
  * Drag-and-drop handles (`⋮⋮`) to reorder columns.
  * `X` button on each item to remove it (except `URL`, which is locked as the primary identifier).
  * **Reset to default** link at the bottom.
* **Persistence:** Column configurations are saved **per user, per project** automatically upon clicking **Apply**, and persist across browser sessions.

*(Sources: Ahrefs Help Center "Page Explorer", "Link Explorer", saved Page Explorer DOM structure, accessed Nov 2026)*

---

## 4. "Show Changes" Comparison Mode

Located in the result bar next to Columns, the **Changes** dropdown controls crawl-over-crawl diffing.

* **Dropdown Options:**
  * `Don't show` (default)
  * `Compare with previous crawl` (or select a specific historical crawl date from a list of stored crawls)
* **Row-Level Status Filter:** When comparison is active, a segmented filter pill appears next to the result count allowing users to filter rows by:
  * **All**
  * **New** (URLs discovered in the current crawl that did not exist in the comparison crawl — marked with a green `New` badge next to the URL)
  * **Lost / Missing** (URLs present in the comparison crawl that were not found or were removed in the current crawl — marked with a red `Lost` badge)
  * **Changed** (URLs present in both crawls where at least one displayed/tracked metric changed)
  * **No change** (URLs identical across both crawls)
* **Cell Formatting for Changed Values:**
  * Unchanged cells display their standard single value in normal text.
  * Changed cells highlight with a subtle light-blue or light-yellow background tint and show both values inline: `Old value` (muted grey, often with strikethrough or small font) `→` `New value` (bold dark text).
  * For numeric metrics (e.g., `Word count`, `No. of inlinks`, `Organic traffic`), a green (`+15`) or red (`-4`) delta badge appears beside the new value.
* **Comparable Fields:**
  * Almost all crawled attributes can be compared: `HTTP status code`, `Is indexable`, `Title`, `Title length`, `Meta description`, `H1`, `Word count`, `Canonical URL`, `Meta robots`, `X-Robots-Tag`, `Depth`, `No. of inlinks`, `No. of outlinks`, `Page size`, `Load time`, `PR`, `Organic traffic`, `Referring domains`, and `Issues count`.

*(Sources: Ahrefs Blog "New Site Audit Features", Ahrefs Help Center "Tracking changes between crawls", accessed Nov 2026)*

---

## 5. URL Details Panel (Tab-by-Tab Specification)

Clicking any URL or its magnifier icon opens a drawer sliding in from the right (covering ~50–60% of viewport width), updating the browser URL query parameter without reloading the list behind it.

### Panel Header
* **Left:** Resource/Page type icon + Page `<title>` (H2 size) + Full URL string. Next to the URL is a small external-link arrow icon (`↗`)—the **only** element that opens the live URL in a new browser tab. Clicking any internal URL elsewhere inside the panel reloads the panel with that target URL's data.
* **Right Action Buttons:**
  * **Submit to IndexNow:** Sends an instant HTTP POST ping for this single URL to the IndexNow API (if configured in project settings) and shows a toast confirmation (`Submitted to IndexNow`).
  * **Export:** Downloads a CSV of all issues and link data for this specific URL.
  * **Close (`X`):** Closes the drawer and clears the URL parameter.

### Left Navigation Rail (Inside Panel)
Displays vertical tabs with numerical count badges on the right edge of each tab. Zero-count tabs are muted/greyed out.

1. **Overview** (No count badge)
   * **Top Summary Strip:** Circular **PR** (Internal PageRank) gauge; **Errors** (red), **Warnings** (yellow), and **Notices** (blue) count pills; **Crawled at** timestamp + **Recrawl** button.
   * **What "Recrawl" does:** Triggers an immediate single-URL live fetch via Ahrefsbot, bypassing the crawl queue, updates the panel's metrics/HTML snapshot in ~3–10 seconds, and updates the row in the background table.
   * **Collapsible Accordion Sections:**
     * *URL info:* Type (HTML/Resource), Is internal (`Yes`/`No`), Full URL, HTTP status badge, First found at, Content type, Depth, Is indexable (`Yes`/`No` + reason if No), Canonical URL + `Self-reference` green badge (or `Non-self` warning badge), Meta robots, X-Robots-Tag (`Missing` grey badge if absent), Present in sitemap (lists exact sitemap XML URL(s) or `No`).
     * *HTTP headers:* Key-value table of all raw HTTP response headers (`server`, `content-type`, `cache-control`, `x-robots-tag`, `strict-transport-security`, etc.).
     * *Performance:* Time to first byte (TTFB in ms), Load time (ms), Content size (KB), Content encoding (`gzip`, `br`, or `None`).
     * *Content:* Title (text + char/pixel length), Meta description (text + length, or red `Missing` badge), H1 (text + length), H2s (numbered ordered list `1. ...`, `2. ...`), Word count, Text-to-HTML ratio (`%`), Language (`html lang`), Social tags (`og:title`, `og:description`, `og:image`, `og:url`, `twitter:card`).
2. **Issues** (Badge: total issues on this URL, colored red if >=1 error)
   * Lists every active issue triggered by this URL, grouped by severity (`Errors`, `Warnings`, `Notices`).
   * Each row shows the severity dot, issue title, and an expandable **Why and how to fix** accordion inline.
   * **Empty state:** Green checkmark illustration + `"No issues found on this URL."`
3. **All inlinks** (Badge: total internal + external incoming links found in crawl)
   * **Toolbar:** `Follow` filter dropdown (`All`, `Dofollow`, `Nofollow`), `Link type` filter (`All`, `Href`, `Redirect`, `Canonical`, `Hreflang`, `Image`, `Resource`), Search box (`Filter by URL or anchor...`), and **Open in Link explorer** button (opens full-screen Link Explorer pre-filtered to `Target URL = this URL`).
   * **Table Columns:** `Source URL` (clickable -> switches panel to source URL) | `Anchor` | `Type` | `Dofollow` (green checkmark `✓` or grey `Nofollow` pill).
   * **Empty state:** `"No incoming links found for this URL during the crawl."`
4. **Href inlinks** (Badge: count of `<a href>` incoming links)
   * Same table and filters as *All inlinks*, filtered strictly to `<a href>` HTML anchor links.
5. **Redirect inlinks** (Badge: count of URLs redirecting to this URL)
   * **Table Columns:** `Source URL` | `Redirect HTTP status` (`301`, `302`, `307`, `308`) | `Redirect type` (`HTTP header` vs `Meta refresh` vs `JavaScript`).
6. **Canonical inlinks** (Badge: count of pages declaring this URL as their `rel="canonical"`)
   * **Table Columns:** `Source URL` | `Source HTTP status` | `Source Is indexable`.
7. **Outlinks internal** (Badge: count of internal outgoing links)
   * **Toolbar:** `Follow` filter (`All`, `Dofollow`, `Nofollow`), `Status` filter (`All`, `200`, `3xx`, `4xx`, `5xx`), Search box, **Open in Link explorer**.
   * **Table Columns:** `Target URL` (clickable -> switches panel to target URL) | `Anchor` | `Target HTTP status` (color badge) | `Dofollow` (`✓` / `Nofollow`).
8. **Outlinks external** (Badge: count of external outgoing links)
   * **Toolbar:** `Follow` filter, `Status` filter, Search box.
   * **Table Columns:** `Target URL` (opens external arrow) | `Anchor` | `Target HTTP status` | `Dofollow` (`✓` / `Nofollow` / `Sponsored` / `UGC`).
9. **Hreflangs** (Badge: count of URLs in the hreflang cluster)
   * **Visual Cluster View:** Interactive node-and-arrow graph + table showing every language/region variant referenced in the cluster, highlighting missing return tags (`Missing reciprocal`), non-200 targets, or mismatched language codes in red.
   * **Table Columns:** `Language / Region` (`en-us`, `x-default`, etc.) | `Target URL` | `HTTP status` | `Return link` (`✓ Valid` or red `Missing`).
   * **Empty state:** `"No hreflang annotations found on this URL."`
10. **Duplicates** (Badge: count of exact or near-duplicate URLs)
    * Sub-tabs or grouped sections for **Exact content duplicates**, **Near duplicates** (with `%` similarity score), **Duplicate title**, **Duplicate meta description**, and **Duplicate H1**.
    * **Table Columns:** `URL` | `HTTP status` | `Is indexable` | `Canonical URL` | `Similarity %`.
    * **Empty state:** `"No duplicate pages or tags found for this URL."`
11. **Image resources** (Badge: count of `<img>` / CSS background images loaded by this page)
    * **Table Columns:** `Image URL` | `HTTP status` | `File size` (KB) | `Alt text` (or red `Missing` badge) | `Dimensions` (`W × H`).
12. **CSS resources** (Badge: count of `.css` stylesheets)
    * **Table Columns:** `CSS URL` | `HTTP status` | `File size` (KB) | `Render-blocking` (`Yes` / `No`).
13. **JavaScript resources** (Badge: count of `.js` scripts)
    * **Table Columns:** `JS URL` | `HTTP status` | `File size` (KB) | `Load attribute` (`Async`, `Defer`, or `Blocking`).
14. **Structured data** (Badge: count of JSON-LD / Microdata / RDFa entities detected)
    * Expandable tree view of each schema entity (e.g., `Article`, `Product`, `BreadcrumbList`, `FAQPage`), displaying parsed key-value properties and inline validation badges:
      * Red `Error`: Missing required Google Rich Result property or syntax error.
      * Yellow `Warning`: Missing recommended property.
      * Green `Valid`: Passes schema.org and Google Rich Result rules.
    * **Empty state:** `"No structured data found on this URL."`
15. **View source** (No count badge)
    * **Controls:**
      * Mode toggle: `Raw HTML` | `Rendered HTML` (DOM after headless Chromium JS execution) | `Page text` (extracted visible text).
      * **Compare with crawl:** Dropdown of historical crawl dates. Selecting an older crawl switches the viewer into a line-by-line diff view highlighting removed lines in red (`-`) and added lines in green (`+`).
      * In-source search box (`Ctrl+F` style match counter + Next/Prev buttons) and line numbers.

*(Sources: Ahrefs Help Center "URL Details Panel", Ahrefs Blog "View Source & Diff in Site Audit", owner's UI screenshots, accessed Nov 2026)*

---

## 6. Issues Presentation, Severity & Custom Issue Creation

### How an Issue is Shown (All Issues Report & Issue Detail Header)
* **Issue Row / Header Components:**
  1. **Severity Indicator:** Solid colored icon/badge—Red circle/exclamation for **Error**, Yellow triangle for **Warning**, Blue info circle for **Notice**.
  2. **Issue Title:** Concise problem name (e.g., `Orphan page (has no incoming internal links)`).
  3. **Category Tag:** e.g., `Links`, `Indexability`, `Content`, `Redirects`, `On-page`, `Performance`, `Localization`, `Structured data`, `Social tags`, `Sitemaps`, `Security`.
  4. **Affected URLs Count:** Clickable number (e.g., `370`) that opens Page Explorer pre-filtered to those exact URLs.
  5. **Change Since Last Crawl:** Delta badge next to the count (e.g., `+12` in red if errors increased, `-5` in green if fixed, or `0` in grey).
  6. **"Why and how to fix" Popover:** Clicking the `?` or `"Why and how to fix"` link next to the title opens a structured help card with two fixed sections:
     * **Issue description / Why it matters:** 1–2 short paragraphs explaining the SEO or technical impact in plain English.
     * **How to fix:** Actionable bullet points or steps to resolve the issue.

### Changing Severity per Project
* In **Project Settings > Issue Settings** (or via the three-dot menu on any issue row in the All Issues report):
  * Users can override the default severity of any built-in issue between `Error`, `Warning`, `Notice`, or `Disabled` (turns off the check for that project).
  * **Health Score Rule:** Only issues set to **Error** reduce the site's Health Score (`0–100`). Changing an issue from `Error` to `Warning` or `Disabled` immediately recalculates the project's Health Score without requiring a recrawl.

### Creating a Custom Issue from a Filter
1. User builds any filter combination in **Page Explorer > Advanced filter** (e.g., `URL contains /blog/` AND `Word count < 500` AND `Organic traffic > 100`).
2. User clicks **Create issue** in the top-right action bar.
3. Modal inputs: **Issue name**, **Severity** (`Error` / `Warning` / `Notice`), and **How to fix** notes.
4. Custom issues appear in the **All Issues** report under a `Custom` category (or chosen category) with a `Custom` badge, track crawl-over-crawl changes, and contribute to the Health Score if marked as `Error`.

*(Sources: Ahrefs Help Center "Site Audit Issues", "How to change issue severity", "Custom issues in Site Audit", accessed Nov 2026)*

---

## 7. Complete Current Ahrefs Site Audit Issue List (172 Checks)

The table below compiles the predefined checks across Ahrefs Site Audit's 14 categories, verified against Ahrefs Help Center ("Issues" collection), Ahrefs Looker Studio Site Audit schema documentation, and public Ahrefs audit reference tables. Items where Ahrefs allows variable default severity or where exact default tier was not explicitly confirmed in 2025/2026 release notes are marked `NOT VERIFIED`.

| Issue Name | Severity | Category | Source |
| :--- | :--- | :--- | :--- |
| 404 page | Error | Internal pages | Ahrefs Help Center - Issues |
| 4XX page | Error | Internal pages | Ahrefs Help Center - Issues |
| 500 page | Error | Internal pages | Ahrefs Help Center - Issues |
| 5XX page | Error | Internal pages | Ahrefs Help Center - Issues |
| Page timed out | Error | Internal pages | Ahrefs Help Center - Issues |
| DNS lookup failed | Error | Internal pages | Ahrefs Help Center - Issues |
| Connection failed | Error | Internal pages | Ahrefs Help Center - Issues |
| Empty page (0 bytes) | Error | Internal pages | Ahrefs Help Center - Issues |
| Page has broken links | Error | Links | Ahrefs Help Center - Issues |
| Page has broken external links | Warning | Links | Ahrefs Help Center - Issues |
| Orphan page (has no incoming internal links) | Warning | Links | Ahrefs Help Center - Issues |
| Page has no outgoing links | Warning | Links | Ahrefs Help Center - Issues |
| Page has only one incoming internal link | Notice | Links | Ahrefs Help Center - Issues |
| Page has links to redirect | Warning | Links | Ahrefs Help Center - Issues |
| Page has broken image | Error | Resources | Ahrefs Help Center - Issues |
| Page has broken CSS | Error | Resources | Ahrefs Help Center - Issues |
| Page has broken JavaScript | Error | Resources | Ahrefs Help Center - Issues |
| Page has redirected image | Notice | Resources | Ahrefs Help Center - Issues |
| Page has redirected CSS | Notice | Resources | Ahrefs Help Center - Issues |
| Page has redirected JavaScript | Notice | Resources | Ahrefs Help Center - Issues |
| Image file size too large | Warning | Resources | Ahrefs Help Center - Issues |
| CSS file size too large | Warning | Resources | Ahrefs Help Center - Issues (NOT VERIFIED) |
| JavaScript file size too large | Warning | Resources | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Missing alt text | Warning | Images | Ahrefs Help Center - Issues |
| Alt text too long | Notice | Images | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Broken image URL | Error | Images | Ahrefs Help Center - Issues |
| Redirected image URL | Notice | Images | Ahrefs Help Center - Issues |
| HTTPS page links to HTTP image | Warning | Security | Ahrefs Help Center - Issues |
| HTTPS page links to HTTP CSS | Warning | Security | Ahrefs Help Center - Issues |
| HTTPS page links to HTTP JavaScript | Warning | Security | Ahrefs Help Center - Issues |
| HTTPS page links to HTTP page | Notice | Security | Ahrefs Help Center - Issues |
| HTTP page has internal links to HTTPS | Notice | Security | Ahrefs Help Center - Issues |
| Redirect chain too long | Error | Redirects | Ahrefs Help Center - Issues |
| Redirect loop | Error | Redirects | Ahrefs Help Center - Issues |
| Broken redirect | Error | Redirects | Ahrefs Help Center - Issues |
| 302 redirect (temporary) | Notice | Redirects | Ahrefs Help Center - Issues |
| 301 redirect | Notice | Redirects | Ahrefs Help Center - Issues |
| 307 redirect | Notice | Redirects | Ahrefs Help Center - Issues |
| 308 redirect | Notice | Redirects | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Meta refresh redirect | Warning | Redirects | Ahrefs Help Center - Issues |
| JavaScript redirect | Notice | Redirects | Ahrefs Help Center - Issues |
| HTTPS to HTTP redirect | Warning | Redirects | Ahrefs Help Center - Issues |
| HTTP to HTTPS redirect | Notice | Redirects | Ahrefs Help Center - Issues |
| Redirected page has no incoming internal links | Notice | Redirects | Ahrefs Help Center - Issues |
| Redirected page has backlinks | Notice | Redirects | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Noindex page | Notice | Indexability | Ahrefs Help Center - Issues |
| Nofollow page | Notice | Indexability | Ahrefs Help Center - Issues |
| Noindex and nofollow page | Warning | Indexability | Ahrefs Help Center - Issues |
| Noindex in HTML and HTTP header | Notice | Indexability | Ahrefs Help Center - Issues |
| Conflicting robots directives (index and noindex) | Error | Indexability | Ahrefs Help Center - Issues |
| Blocked by robots.txt | Notice | Indexability | Ahrefs Help Center - Issues |
| Blocked by X-Robots-Tag | Notice | Indexability | Ahrefs Help Center - Issues |
| Meta robots tag missing | Notice | Indexability | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Page has nofollow incoming internal links only | Warning | Links | Ahrefs Help Center - Issues |
| Page has nofollow and dofollow incoming internal links | Notice | Links | Ahrefs Help Center - Issues |
| Page has nofollow outgoing internal links | Notice | Links | Ahrefs Help Center - Issues |
| Page has too many outgoing links | Warning | Links | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Canonical points to 4XX | Error | Canonicals | Ahrefs Help Center - Issues |
| Canonical points to 5XX | Error | Canonicals | Ahrefs Help Center - Issues |
| Canonical points to redirect | Warning | Canonicals | Ahrefs Help Center - Issues |
| Canonical points to non-canonical page (canonical chain) | Warning | Canonicals | Ahrefs Help Center - Issues |
| Canonical points to noindex page | Warning | Canonicals | Ahrefs Help Center - Issues |
| Canonical URL is relative | Warning | Canonicals | Ahrefs Help Center - Issues |
| Multiple canonical tags | Error | Canonicals | Ahrefs Help Center - Issues |
| Canonical tag missing | Notice | Canonicals | Ahrefs Help Center - Issues |
| Non-canonical page | Notice | Canonicals | Ahrefs Help Center - Issues |
| Canonical from HTTPS to HTTP | Warning | Canonicals | Ahrefs Help Center - Issues |
| Canonical from HTTP to HTTPS | Notice | Canonicals | Ahrefs Help Center - Issues |
| Canonical URL has no incoming internal links | Warning | Canonicals | Ahrefs Help Center - Issues |
| Title tag missing or empty | Error | On-page | Ahrefs Help Center - Issues |
| Title too long | Warning | On-page | Ahrefs Help Center - Issues |
| Title too short | Warning | On-page | Ahrefs Help Center - Issues |
| Duplicate title | Warning | On-page | Ahrefs Help Center - Issues |
| Multiple title tags | Warning | On-page | Ahrefs Help Center - Issues |
| Title same as H1 | Notice | On-page | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Meta description tag missing or empty | Warning | On-page | Ahrefs Help Center - Issues |
| Meta description too long | Warning | On-page | Ahrefs Help Center - Issues |
| Meta description too short | Warning | On-page | Ahrefs Help Center - Issues |
| Duplicate meta description | Warning | On-page | Ahrefs Help Center - Issues |
| Multiple meta description tags | Warning | On-page | Ahrefs Help Center - Issues |
| H1 tag missing or empty | Warning | On-page | Ahrefs Help Center - Issues |
| Multiple H1 tags | Warning | On-page | Ahrefs Help Center - Issues |
| H1 too long | Notice | On-page | Ahrefs Help Center - Issues |
| Duplicate H1 | Warning | On-page | Ahrefs Help Center - Issues |
| Low word count | Warning | Content | Ahrefs Help Center - Issues |
| Exact duplicate pages without canonical | Error | Content | Ahrefs Help Center - Issues |
| Exact duplicate pages with canonical | Notice | Content | Ahrefs Help Center - Issues |
| Near duplicate pages | Warning | Content | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Low text-to-HTML ratio | Notice | Content | Ahrefs Help Center - Issues |
| Lorem ipsum placeholder text found | Warning | Content | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Slow page (high load time) | Warning | Performance | Ahrefs Help Center - Issues |
| Slow Time to First Byte (TTFB) | Warning | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Page file size too large | Warning | Performance | Ahrefs Help Center - Issues |
| Uncompressed page (missing GZIP/Brotli) | Warning | Performance | Ahrefs Help Center - Issues |
| Uncompressed JavaScript or CSS | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Unminified JavaScript or CSS | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Too many JavaScript files | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Too many CSS files | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Render-blocking JavaScript | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Render-blocking CSS | Notice | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Poor Core Web Vitals: LCP | Warning | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Poor Core Web Vitals: CLS | Warning | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Poor Core Web Vitals: INP | Warning | Performance | Ahrefs Help Center - Issues (NOT VERIFIED) |
| 3XX page in sitemap | Warning | Sitemaps | Ahrefs Help Center - Issues |
| 4XX page in sitemap | Error | Sitemaps | Ahrefs Help Center - Issues |
| 5XX page in sitemap | Error | Sitemaps | Ahrefs Help Center - Issues |
| Noindex page in sitemap | Warning | Sitemaps | Ahrefs Help Center - Issues |
| Non-canonical page in sitemap | Warning | Sitemaps | Ahrefs Help Center - Issues |
| Page blocked by robots.txt in sitemap | Warning | Sitemaps | Ahrefs Help Center - Issues |
| Timed out page in sitemap | Error | Sitemaps | Ahrefs Help Center - Issues |
| Indexable page not in sitemap | Notice | Sitemaps | Ahrefs Help Center - Issues |
| Page present in multiple sitemaps | Notice | Sitemaps | Ahrefs Help Center - Issues |
| Sitemap file too large (>50MB or >50,000 URLs) | Error | Sitemaps | Ahrefs Help Center - Issues |
| Sitemap XML format error | Error | Sitemaps | Ahrefs Help Center - Issues |
| Hreflang to 4XX | Error | Localization | Ahrefs Help Center - Issues |
| Hreflang to 5XX | Error | Localization | Ahrefs Help Center - Issues |
| Hreflang to redirect | Warning | Localization | Ahrefs Help Center - Issues |
| Hreflang to non-canonical | Warning | Localization | Ahrefs Help Center - Issues |
| Hreflang to noindex page | Warning | Localization | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Hreflang to page blocked by robots.txt | Warning | Localization | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Missing reciprocal hreflang (no return tag) | Error | Localization | Ahrefs Help Center - Issues |
| Hreflang annotation invalid (wrong language/region code) | Error | Localization | Ahrefs Help Center - Issues |
| Self-referencing hreflang annotation missing | Warning | Localization | Ahrefs Help Center - Issues |
| X-default hreflang annotation missing | Notice | Localization | Ahrefs Help Center - Issues |
| Page referenced for more than one language in hreflang | Error | Localization | Ahrefs Help Center - Issues |
| More than one page for the same language in hreflang | Error | Localization | Ahrefs Help Center - Issues |
| HTML lang attribute missing | Notice | Localization | Ahrefs Help Center - Issues |
| HTML lang attribute invalid | Warning | Localization | Ahrefs Help Center - Issues |
| Hreflang and HTML lang mismatch | Warning | Localization | Ahrefs Help Center - Issues |
| Open Graph tags incomplete | Notice | Social tags | Ahrefs Help Center - Issues |
| Open Graph tags missing | Notice | Social tags | Ahrefs Help Center - Issues |
| Open Graph URL not matching canonical | Warning | Social tags | Ahrefs Help Center - Issues |
| Open Graph image broken (4XX/5XX) | Warning | Social tags | Ahrefs Help Center - Issues |
| Open Graph image redirected | Notice | Social tags | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Twitter card tags incomplete | Notice | Social tags | Ahrefs Help Center - Issues |
| Twitter card tags missing | Notice | Social tags | Ahrefs Help Center - Issues |
| Twitter card image broken | Warning | Social tags | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Structured data parse error (JSON-LD/Microdata syntax) | Error | Structured data | Ahrefs Help Center - Issues |
| Structured data missing required property | Error | Structured data | Ahrefs Help Center - Issues |
| Structured data missing recommended property | Warning | Structured data | Ahrefs Help Center - Issues |
| Structured data invalid field value / type | Error | Structured data | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Structured data deprecated type | Warning | Structured data | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Structured data image broken | Warning | Structured data | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Viewport meta tag missing | Warning | Mobile | Ahrefs Help Center - Issues |
| Viewport meta tag invalid / fixed width | Warning | Mobile | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Flash content used | Warning | Mobile | Ahrefs Help Center - Issues (NOT VERIFIED) |
| SSL certificate expired or invalid | Error | Security | Ahrefs Help Center - Issues |
| SSL certificate expires soon | Warning | Security | Ahrefs Help Center - Issues |
| Mixed content (HTTPS page loads HTTP resource) | Warning | Security | Ahrefs Help Center - Issues |
| Missing HSTS header | Notice | Security | Ahrefs Help Center - Issues |
| Missing Content-Security-Policy header | Notice | Security | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Missing X-Content-Type-Options header | Notice | Security | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Missing X-Frame-Options header | Notice | Security | Ahrefs Help Center - Issues (NOT VERIFIED) |
| HTTP URLs accessible (no forced HTTPS) | Warning | Security | Ahrefs Help Center - Issues |
| Malformed URL (invalid characters) | Warning | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| URL too long | Notice | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| URL contains uppercase characters | Notice | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| URL contains underscores | Notice | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| URL contains double slashes | Warning | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| URL contains query parameters | Notice | URLs | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Depth greater than 3 clicks | Notice | Links | Ahrefs Help Center - Issues |
| Paginated page has noindex | Notice | Pagination | Ahrefs Help Center - Issues (NOT VERIFIED) |
| First paginated page has rel="prev" | Notice | Pagination | Ahrefs Help Center - Issues (NOT VERIFIED) |
| Paginated page canonicalized to page 1 | Warning | Pagination | Ahrefs Help Center - Issues (NOT VERIFIED) |
| AMP page has HTML/AMP validation errors | Error | AMP | Ahrefs Help Center - Issues (NOT VERIFIED) |
| AMP canonical mismatch | Error | AMP | Ahrefs Help Center - Issues (NOT VERIFIED) |
| 3XX page receives organic traffic | Warning | Traffic & Metrics | Ahrefs Help Center - Issues |
| 4XX page receives organic traffic | Error | Traffic & Metrics | Ahrefs Help Center - Issues |
| 5XX page receives organic traffic | Error | Traffic & Metrics | Ahrefs Help Center - Issues |
| Noindex page receives organic traffic | Warning | Traffic & Metrics | Ahrefs Help Center - Issues |
| Non-canonical page receives organic traffic | Warning | Traffic & Metrics | Ahrefs Help Center - Issues |
| 4XX page has backlinks / referring domains | Warning | Traffic & Metrics | Ahrefs Help Center - Issues |


---

(Section 8 and sources were sent separately by Gemini and joined here by Claude.)

## 8. High-Value Features Competitors Do Better (Ideas for SmartBot)

Pixel-Width SERP Snippet Preview & Truncation Detection (Screaming Frog SEO Spider): Instead of only counting character length (which fails on wide characters like W vs i), Screaming Frog calculates exact rendered pixel width (e.g., 580px for titles, 920px for descriptions) and shows a live desktop/mobile Google SERP preview inside the bottom/side URL panel. (Source: Screaming Frog SEO Spider User Guide - Page Titles & Meta Descriptions)
Inlink Anchor Text & DOM Location Context (Screaming Frog & Sitebulb): In the Inlinks tab, Screaming Frog shows where on the source page the link sits (Navigation, Header, Footer, Sidebar, or Main Content) plus the surrounding text snippet. This immediately tells the user whether an inlink is a real contextual editorial link or just a site-wide menu link. (Source: Screaming Frog SEO Spider User Guide - Inlinks Tab)
Interactive Crawl Path / Shortest Click-Depth Tree (Sitebulb): Sitebulb's URL Details view includes a "Crawl Path" tab showing the exact chain of clicks (Homepage -> /blog/ -> /category/ -> /target-page/) that the crawler took to discover the page, making it effortless to fix deep-click pages. (Source: Sitebulb Documentation - URL Details & Crawl Paths)
Custom XPath / CSS Selector Extraction Columns (Screaming Frog): Allows users to define 1–5 custom XPath or CSS rules per site (e.g., extracting author name, publish date, product price, or schema @type) so those extracted values appear directly as filterable, sortable columns in Page Explorer. (Source: Screaming Frog SEO Spider User Guide - Custom Extraction)
Actionable Fix Priority & Effort Matrix (Sitebulb "Hints"): Sitebulb groups issues by potential SEO impact vs. implementation difficulty and shows a "Coverage %" bar (what percentage of indexable pages pass vs. fail the check), helping non-technical site owners prioritize fixes better than raw URL counts. (Source: Sitebulb Documentation - Audit Hints & Prioritization)
GSC Query-to-Page Cannibalization & Top Queries Tab in Panel (Sitebulb & Semrush): While Ahrefs only shows aggregate organic traffic in the panel, Sitebulb's URL Details panel integrates Google Search Console directly to list the top 10–25 search queries, impressions, CTR, and average position for that specific URL, flagging if another internal page ranks higher for the same query. (Source: Sitebulb Documentation - Google Search Console Integration)
Inline "Send to Task / Fix Draft" Workflow from Any Issue Row (Semrush Site Audit): Semrush lets users tick specific URLs inside an issue table and push them directly into a built-in task board or Trello/Jira export with pre-filled fix instructions, avoiding manual CSV copy-pasting. (Source: Semrush Knowledge Base - Site Audit Task Management)
Side-by-Side Split-Screen Diff for Raw vs. Rendered HTML & Text (Screaming Frog): Rather than only diffing across crawl dates, Screaming Frog allows viewing Raw HTML next to Rendered HTML (or comparing two crawls side-by-side) to spot missing links or content injected late by JavaScript. (Source: Screaming Frog SEO Spider User Guide - Compare Crawls)
Interactive Directory / URL Structure Tree Filter (Sitebulb & Screaming Frog): Alongside the flat URL table, a collapsible folder tree sidebar (/blog/, /products/, /en/) lets users click any subfolder to instantly filter Page Explorer and see folder-level health scores and aggregate word counts. (Source: Screaming Frog SEO Spider User Guide - Site Structure Tab)
Bulk "Re-verify Fixed" on Selected Rows (Semrush Site Audit): Instead of recrawling one URL at a time in the panel or re-running the entire site crawl, Semrush lets users select 5–50 URLs via checkboxes in the issue list and click "Re-check" to verify fixes in seconds. (Source: Semrush Knowledge Base - Re-running Site Audit Checks)
Sources List

Ahrefs Help Center — Site Audit Collection (https://help.ahrefs.com/en/collections/2253907-site-audit, accessed 17 Nov 2026) — Verified Page Explorer presets, Advanced Filter operators, URL Details Panel tabs, and issue descriptions.
Ahrefs Academy — Site Audit Course (https://ahrefs.com/academy/site-audit, accessed 17 Nov 2026) — Verified crawl comparison workflow, Health Score rules, and Link Explorer columns.
Ahrefs Blog — New Site Audit Features (2024–2026) (https://ahrefs.com/blog/new-site-audit-features/, accessed 17 Nov 2026) — Verified "Show changes" cell diffing, View Source crawl-date diff, IndexNow button, and AI Discoverability filter tab.
Ahrefs Looker Studio Connector Documentation — Site Audit Fields (https://docs.ahrefs.com/, accessed 17 Nov 2026) — Verified complete schema of Page Explorer metrics, link attributes, and issue classifications.
Screaming Frog SEO Spider User Guide (https://www.screamingfrog.co.uk/seo-spider/user-guide/, accessed 17 Nov 2026) — Verified pixel-width SERP preview, DOM link position tracking, custom extraction, and crawl comparison features.
Sitebulb Documentation — URL Details & Audit Hints (https://sitebulb.com/documentation/, accessed 17 Nov 2026) — Verified Crawl Path visualization, GSC query-level panel integration, and Hint coverage scoring.
Semrush Knowledge Base — Site Audit (https://www.semrush.com/kb/site-audit/, accessed 17 Nov 2026) — Verified bulk URL re-verification and task-pushing workflows.

END OF BRIDGE-ANSWER G-002
