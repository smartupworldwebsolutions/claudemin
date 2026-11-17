# PROJECTS - what Gemini and Claude work on (no passwords, keys or client data here)

| Project (name used in STATUS.md) | What it is | Where the code / notes live | Rules for Gemini drafts |
|---|---|---|---|
| smartbot | SmartBot - Mahmud's self-learning website assistant (site audit, SEO, indexing first; more expertises later), sold to clients as a hosted subscription at smartbot.smartupworld.com (public site at /, dashboard at /admin/) | private repo smartupworldwebsolutions/smartbot | Python 3.6-safe, standard library + PyMySQL only, `%` formatting, SQL with `%s` args, new features as plugins (AI_GUIDE.md). Client website data never leaves Mahmud's machines. Nothing is published to a live website by itself - drafts only. |
| smartupworld-site | smartupworld.com - the company website (WordPress theme + pages, SmartBot product page, blog) | Mahmud's Claude project "SmartUpWorld SEO and Theme development" | WordPress PHP; follow the theme's existing structure; no plugin bloat. |
| client-sites | Client websites Mahmud manages (WordPress / WooCommerce, e.g. shops) | per client - Claude copies what is needed into tasks/client-sites/context/ | Never name clients' private data; drafts only - Claude installs. |
| new-apps | New apps or plugins Mahmud starts with Gemini (e.g. storrent) | added here when they get their own repo | Ask Mahmud first, then a full first draft (GEMINI.md section 6). |
