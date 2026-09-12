# ECC layer for NRV AI Factory

Source: https://github.com/affaan-m/ECC
License: MIT

This file integrates the strongest ECC ideas into NRV AI Factory without replacing existing NRV rules.

## Purpose

Use ECC as an additional quality and verification layer for NRV projects.

## Default workflow

For any serious project task, follow this order:

1. Analyze repository structure and current project state.
2. Read project-specific rules and constraints.
3. Identify affected surfaces before editing.
4. Plan the smallest safe set of changes.
5. Implement.
6. Run verification loop: build, tests, lint, typecheck where available.
7. Run security review where auth, API, Supabase, secrets, uploads, payments or user data are involved.
8. Run UI/UX and mobile regression checks for frontend changes.
9. Review git diff and confirm no unrelated files were changed.
10. Re-check the original user request and verify every requested item.
11. Only report completion when evidence supports it.

## ECC-inspired modes

### FULL AUDIT
Architecture, code quality, frontend, backend, security, tests, dependencies, performance, UX, accessibility, deployment and regressions.

### SECURITY
Secrets, authentication, authorization, Supabase RLS, API boundaries, validation, XSS, CSRF where applicable, dependency vulnerabilities and exposed configuration.

### UI_UX
Responsive behavior, mobile overflow, clipping, spacing, readability, contrast, dark/light themes, touch targets, forms and navigation.

### CODE QUALITY
Dead code, duplicated logic, unsafe patterns, inconsistent state, weak error handling, poor separation of concerns and maintainability risks.

### PERFORMANCE
Bundle size, unnecessary renders, heavy assets, blocking work, inefficient data fetching, repeated requests and avoidable dependencies.

### VERIFY
Do not make new product changes. Re-test previously completed work and search for regressions.

### AUTOFIX
Find defects, fix them within scope, then run the full verification loop again.

### DEPLOY CHECK
Build, environment assumptions, routing, production-only failures, Vercel compatibility and post-deploy smoke checks.

## NRV-specific additions

ECC does not replace NRV rules. NRV rules remain authoritative for the user's projects.

Always include these checks when relevant:

- mobile horizontal overflow;
- cards or sections clipped on narrow screens;
- excessive vertical gaps;
- broken buttons and links;
- forms that silently fail;
- theme inconsistencies;
- admin routes exposed to normal users;
- Supabase RLS and anon permissions;
- public/private publication flags;
- Vercel build and routing issues;
- regression checks after every fix;
- do not claim "done" before verification.

## Project exclusions

RB-24 / SHAMKIREC/RB must not be modified through this factory unless the user explicitly asks to include it.

## External-action boundary

Inspect and prepare changes freely within the requested scope. Do not modify unrelated repositories or third-party resources. Preserve secrets and existing configuration.

## Short commands understood by NRV AI Factory

- "Полный прогон <project>" -> FULL AUDIT + VERIFY
- "Прогони безопасность <project>" -> SECURITY
- "Проверь мобильную <project>" -> UI_UX focused on responsive/mobile
- "Найди и исправь косяки <project>" -> AUTOFIX + VERIFY
- "Перепроверь что сделали" -> VERIFY
- "Проверь перед релизом" -> DEPLOY CHECK + SECURITY + VERIFY

## Upstream ECC notes

ECC Codex guidance includes skills such as TDD workflow, security review, coding standards, frontend/backend patterns, E2E testing and a verification loop. It also recommends preserving existing user configuration and treating networked actions conservatively.

This NRV integration intentionally imports the workflow principles first instead of blindly copying every ECC skill into every project. Add individual upstream skills only when they materially improve a project's workflow.
