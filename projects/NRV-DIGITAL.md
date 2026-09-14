# NRV-DIGITAL

- Repository: SHAMKIREC/NRV-DIGITAL
- Production: https://nrv64.ru/
- Status: IN_PROGRESS
- Current task: NRV-001
- Quality profile: SHOWCASE_WEB
- Mode: FULL AUDIT + AUTOFIX + VERIFY
- Next action: inspect every public page and shared UI surface, fix defects, deploy, live-regression with TinyFish

## Owner directive

NRV-DIGITAL is now the only active Factory product. The required result is a release-ready showcase website, not a partial visual patch.

Required coverage:
- all public pages and routes;
- every visible button/link/form and mobile menu;
- header and footer consistency;
- typography scale, line-height, spacing and section rhythm;
- card sizes, borders, shadows, hover/touch states and visual hierarchy;
- premium but restrained motion, smooth transitions and reduced-motion fallback;
- mobile clipping/overlap/overflow and sticky-header behavior;
- desktop responsive behavior;
- accessibility basics, focus states and touch targets;
- SEO/meta/link integrity and performance basics;
- post-deploy smoke tests and visual regression.

User screenshots are defect evidence and must be compared against current production.
