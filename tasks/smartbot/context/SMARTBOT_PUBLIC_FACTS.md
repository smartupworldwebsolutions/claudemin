# SmartBot facts for the blog (copied from the SmartBot brief; public facts only)
## 1. What SmartBot is (one paragraph for the page)

SmartBot is a self-learning website-audit assistant. A client adds their website; SmartBot reads its pages every day, runs dozens of SEO, technical, content, speed, security and uptime checks, compares the site with competitors it finds by itself, reads the client's real Google Search Console / Analytics data, and gives a short ordered list of what to fix first. It writes **drafts** of fixes; the client approves and applies them. **It never publishes anything to a client's website by itself.** It learns: from real results (did a fix really raise clicks, positions or indexing?), from competitors, and from official documentation, and it gets better at each website over time.

Positioning line from the owner's research (3 Nov 2026): do **not** claim "better than Ahrefs/Semrush" (SmartBot has no backlink database or keyword volumes). Sell **"it gets better at *your* site"**, real results, plain language, and a fair price. Avoid "smarter because AI" as a headline.

Company voice (from smartupworld.com): plain-spoken, budget-conscious, reassuring, first person plural. Phrases to echo: "at prices that actually make sense", "No hidden fees, no surprise invoices", "without the tech headaches". Not startup-slick, not enterprise.

---
## 3. What a client can do (functionality guide)

All of this is already built and running (54 plugins loaded, none failed, 15 Nov 2026). Use these facts for feature cards, the features page and the usage tutorials. Left menu = the chosen website; top bar = SmartBot itself.

### 3.1 Audits (finding what is wrong)
- **Daily trickle**: a few pages per website are checked all day (50/day default) so results stay fresh with no load on the site.
- **Deep audit & Turbo**: full crawl of the whole site, fast but polite (adapts speed to how the site copes), live progress, real Stop. Builds the **link map** (click depth, internal PageRank, orphan pages, pages missing from sitemap), finds exact and near-duplicate pages, gives a **health score** and a **Fix first** list. 56 checks in this module alone (Nov 3 count; the live total is shown on SmartBot's own site).
- **Site audit Pro** (Ahrefs-style): link structure, redirects (3XX/5XX in sitemap), social tags (Open Graph, X cards), language, structured-data errors, **JavaScript rendering in a real browser**, traffic checks (pages that dropped out of Google's top 10), and a **day-by-day history of issues added / fixed**.
- **Technical SEO**: canonicals, mobile viewport, page weight, indexability, redirect chains/loops, hreflang, sitemaps; health score, new/fixed issues, alerts for dangerous changes, CSV export, AI fix ideas.
- **Discovery Pro**: IndexNow instant indexing, Google-style snippet pixel widths, hreflang return-tag checks, redirect lab, llms.txt and AI-crawler policy builder, server-log bot analyser, affiliate-link shield, og:image checks.
- **Reading results**: *Fix first* (short ordered list), *All issues* (grouped by type/severity, CSV export), a *page detail view* (every problem on a page and how to fix it), *Change monitor* (title/description/indexing/canonical/H1 changes, warns about noindex). Severity: Critical / Warning / Notice. A module that has not run says "Not checked yet", never "0 issues".

### 3.2 Content & on-page tools
- **On-page SEO**: missing/long/short/duplicate titles and descriptions, missing H1, doctype, charset.
- **Duplicate articles** (cannibalisation): articles competing for the same topic, which one to keep.
- **Outdated sentences**: exact titles/headings/sentences mentioning old years.
- **Internal links**: suggests 3–5 links (with anchor text) for pages with almost none.
- **Orphan pages**: pages nothing links to + which pages should link to them.
- **Broken links**: in articles, with which articles contain them.
- **Image SEO**: alt text, generic filenames, missing width/height, optional file-size check.
- **Structured data**: reads existing JSON-LD/Microdata, reports missing/broken markup (does not insert anything).
- **Fix drafter** (needs AI): drafts better titles, meta descriptions, sections to add, grounded in the page's findings. Always a draft the client approves.
- **Article ideas**: topics competitors cover that the site doesn't; can draft writing briefs.

### 3.3 Real Google data
- **"Connect with Google"** button per website (no Google Cloud setup for clients): **Search Console** (clicks, impressions, positions, keywords, quick-win pages, pages that lost traffic), **Analytics GA4** (visitors, engagement, sources), **Rank tracker** (daily positions: winners, losers, new/lost keywords, history).
- **Core Web Vitals** (LCP, CLS, INP) via Google's free PageSpeed API; **Speed watch** (weekly trend, slow/heavy pages).

### 3.4 Competitors & AI-search readiness
- **Competitor finder** discovers competing sites by itself and learns which ones the client accepts; **content gaps** list what they cover that the client doesn't.
- **AI search readiness (GEO)**: llms.txt, whether AI crawlers (GPTBot, ClaudeBot, PerplexityBot…) are allowed, semantic HTML.

### 3.5 Staying online and safe
- **Uptime, SSL and domain expiry** alerts (downtime with minutes).
- **Security & HTTPS**: TLS version, certificate, HSTS, HTTP→HTTPS redirect, security score.
- **WordPress & security health**: common WordPress exposures (e.g. public debug.log) and missing security headers.

### 3.6 Talking to SmartBot, reports, accounts
- **Chat**: ask SmartBot questions; it answers from its own memory first and can take real actions only after the user presses Approve. Super admin can switch chat on/off for users.
- **Assistant**: SmartBot's questions/requests for the user in one place (missing key, decision, access).
- **Email reports** per website with chosen recipients and frequency; a report is only sent when there is something new.
- **People & roles**: super admin, admin, team member, client. Per-website access: viewer / contributor / manager. 2-step sign-in, new-device alerts, sign-in history, "view as client". **Client view**: owner chooses exactly which pages, boxes and report sections clients see; SmartBot's internal pages are hidden from clients by default.
- **Website ownership check**: a sign-up user must prove they own a website (DNS record) before it is audited (decided 14 Nov; check live whether it is built).

### 3.7 Subscription system (how clients pay and are limited)
- States: trial → active → grace (3 days) → expired. **When a subscription ends the client keeps read-only access to OLD findings but gets NO new audits, checks, AI or exports.** This is enforced on the server for every action and background job, not just hidden buttons. SmartBot's own learning from lessons (not site data) is kept.
- Limits are per plan and overridable per person: websites, pages per audit, pages checked per month, competitors, manual audits per month, hours between manual audits, AI answers per month. Buttons that are blocked say why ("Next audit possible on …").
- Payments: manual (owner enables after payment) **and crypto** (customer pays USDT/USDC to the owner's own wallet; SmartBot finds the payment on the blockchain and starts/extends the subscription itself; no payment gateway). Card payments are hard from Bangladesh, hence crypto. Stripe is a possible later addition.
- **Free plan with public sign-up** is built and open on the live site (automatic after email confirmation; spam held back by limits; robot check planned).
- Super admin tools: plans page, per-client subscription card (+1/2/3 months, pause, resume, cancel, switch plan, limit overrides, notes), payments ledger and invoices, overview (counts, income, expiring list), reminders by email, audit log, trials.

### 3.8 How SmartBot learns and looks after itself (for the "Why SmartBot" section)
- **Learns per website**: when the user marks a page "Needs work"/"Fine", that website's own check weights move toward the user's judgement. A shop and a blog end up with different weights. Ratings on one website never change another's.
- **Learns from real results** (plugin *Outcomes*): every fix gets a dated record; 14, 28 and 56 days later it compares clicks, impressions, position and indexing with before **and with similar unchanged pages**, and learns which fixes really work for that kind of site. Every number says how much data it rests on.
- **Brain**: lifelong memory in `brain.db` (per-website diary, survives updates) and `wisdom.db` (lessons written *without* website names, survive when a client deletes a website). Own small neural networks ("own brain") judge and score pages and must beat the plain rules on never-seen pages, or they are rolled back.
- **Knowledge library**: built-in knowledge packs plus daily reading of free official docs (Google Search, web.dev, WordPress and more), and notices when they change.
- **Mind** (self-care): guards every job, pauses a failing one and retries, groups errors into plain-English bugs, forecasts disk/memory problems.
- **Smart engine**: learns each server's quiet hours and each website's audience time zone; works fast when quiet, gently when busy. One website never waits for another.
- **Self-updates**: new versions are tested first, installed, and rolled back automatically if something breaks.
- **In progress (do not promise on pages)**: a real AI language model as SmartBot's "brain" (design approved 14 Nov; steps P1-x in the repo), internet learner, code Lab, "Money/Earn" ideas for the owner. Describe these only as "SmartBot keeps getting smarter", not as features.

### 3.9 Honest "what it does NOT do" (must appear on the pages)
- No backlink database and no keyword search volumes (those need a web-scale crawl). It uses the client's own Search Console data.
- It does not edit the client's website. It drafts; the client changes the site.
- AI features (fix drafts, briefs, plain-language answers) need an AI connection (the owner provides it on the hosted service); every check works without AI.
- Nothing is published by itself.

---

## 4. Plans and prices

The hosted plans exist in code (`core/subs.py`). **Prices are the owner's decision and can change in the dashboard: the pages must read live pricing (the SmartBot `/pricing` page, or `smartbot.json`), never hard-code them.** Starting values as of 15 Nov 2026 (check live):

| Plan | Price | Websites | Pages per audit | Pages checked / month | Competitors | Manual audits / month | Gap between manual audits | AI answers / month |
|---|---|---|---|---|---|---|---|---|
| Free | $0 | 1 | 10 | 10 | 0 | 1 | 30 days | 0 |
| Lite | $20 / month | 2 | 2,500 | 10,000 | 2 | 4 | 48 h | 20 |
| Standard | $49 / month | 3 | 10,000 | 50,000 | 5 | 8 | 48 h | 100 |
| Advanced | $99 / month | 10 | 25,000 | 150,000 | 10 | 30 | 24 h | 500 |

Notes: Free = one audit of at most 10 pages, then nothing updates until the month resets; Deep audit is locked on Free. Taglines: Free "Try SmartBot on one website - no card needed."; Lite "For a small business with one or two websites."; Standard "For growing websites and freelancers."; Advanced "For agencies and big websites." Standard/Advanced prices ($49/$99) were agreed with the owner on 11 Nov after comparing Ahrefs, Semrush and Labrika. Smartupworld's older website-maintenance plans are a different product: Basic $79, Standard $149, Premium $299 per month.

Page idea: a comparison table that is honest about gaps, plus the pricing-model argument "no credit puzzle, plain limits, you see what you used".

---
## 7. Safety and trust rules to state on the pages (true today)

- A client's website data (addresses, page text, audit rows, names, keys) never leaves the owner's machines. SmartBots may share *learning* (lessons without website names), never site data.
- Nothing is published to a client's website by itself; SmartBot makes drafts.
- AI services inside SmartBot give text and advice only, never code that runs. Secrets are removed before anything goes to an AI; AI keys are stored encrypted.
- Client-role users see only their own websites; SmartBot's internal pages are hidden from clients.
- Every number says how much data it rests on; no screen claims a check that did not run.

---

