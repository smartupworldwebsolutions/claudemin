# G-001 - help texts for 77 new audit checks (bulk writing)

**What it is for:** SmartBot's audit (plugins/deep_audit.py in the SmartBot repo, dictionary ISSUES) gets ~77 new checks so it covers
what Ahrefs Site Audit checks (tasks/smartbot/context/AHREFS_ISSUE_LIST_DESIGN.md, "Phase 1"). Claude writes the check code; you write the
texts people read. Match the tone and length of the example row below.

**Answer:** one CSV file, `File: G-001-checks.csv`, header exactly:
`key,severity,category,label,why,how`
- key: lowercase_with_underscores, short, unique, not one of these existing keys: http_4xx http_5xx http_none redirect_loop redirect_chain redirect blocked broken_links orphan few_inlinks links_to_redirect mixed_content title_missing dup_content noindex canonical_bad canonical_other canonical_missing canonical_multi noindex_in_sitemap xrobots_noindex img_noalt img_nodim no_lang no_og no_schema no_twitter no_viewport slow heavy not_compressed no_cache no_hsts
- severity: critical | warning | notice (critical = hurts Google or visitors badly; notice = small improvement)
- category: Response, Indexability, Links, Content, Images, Resources, Sitemap, Hreflang, Markup, Speed, Security, URL, Changes, Google
- label: the check's name, max 70 characters
- why: ONE sentence, max 120 characters - what goes wrong for visitors or Google
- how: 1-2 sentences, max 200 characters - the concrete fix (mention WordPress where it helps)
- double quotes around a cell that contains a comma. One row per check below (77 rows).
Example row: `http_4xx,critical,Response,Page not found / client error (4xx),Visitors and Google hit a dead end.,"Restore the page, or 301-redirect it to the best matching page and remove it from the sitemap."`
After the CSV, a short list: any check where you think the severity is debatable, with one line why.

**The checks:**
Page has broken image; Page has broken CSS; Page has broken JavaScript; Image redirects; CSS redirects; JavaScript redirects;
Image file size too large; CSS file size too large; JavaScript file size too large; HTTPS page links to HTTP image; HTTPS page
links to HTTP CSS; HTTPS page links to HTTP JavaScript; Canonical from HTTP to HTTPS; Canonical from HTTPS to HTTP; Canonical
points to 4XX; Canonical points to 5XX; Canonical points to redirect; Non-canonical page specified as canonical one; Canonical URL
has no incoming internal links; Noindex follow page; Noindex and nofollow page; Nofollow page; Noindex in HTML and HTTP header;
Nofollow in HTML and HTTP header; Redirect chain too long; Broken redirect; HTTPS to HTTP redirect; Meta refresh redirect; 3XX
redirect in sitemap; 4XX page in sitemap; 5XX page in sitemap; Non-canonical page in sitemap; Indexable page not in sitemap; Page
in multiple sitemaps; Page from sitemap timed out; Page has nofollow incoming internal links only; Page has nofollow and dofollow
incoming internal links; Page has no outgoing links; Page has nofollow outgoing internal links; Redirected page has no incoming
internal links; HTTPS page has internal links to HTTP; External link broken (4XX); External link server error (5XX); External
link redirects (3XX); Multiple title tags; Multiple meta description tags; Hreflang annotation invalid; Missing reciprocal
hreflang; Hreflang to broken page; Hreflang to redirect; Hreflang to non-canonical page; Self-referencing hreflang missing;
X-default hreflang missing; Hreflang and HTML lang mismatch; More than one page for same language in hreflang; Page referenced
for more than one language in hreflang; HTML lang attribute invalid; Open Graph URL not matching canonical; Open Graph tags
incomplete; Structured data JSON parsing error; Structured data missing required property; Structured data invalid date format;
Structured data image missing; JavaScript render-blocking; CSS render-blocking; Largest Contentful Paint image lazy-loaded; Title
changed since last audit; H1 changed since last audit; Meta description changed since last audit; Word count changed a lot since
last audit; Indexable page became non-indexable; 3XX page receives Google clicks; 4XX page receives Google clicks; 5XX page
receives Google clicks; Noindex page receives Google clicks; Non-canonical page receives Google clicks; Google clicks dropped;
Page dropped out of Google top 10.
