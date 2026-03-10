---
name: clean-code
description: Pragmatic coding standards for Flutter - concise, direct, secure, and robust error handling.
allowed-tools: Read, Write, Edit
version: 2.0
priority: CRITICAL
---

# Clean Code - Pragmatic AI Coding Standards (Flutter)

> **CRITICAL SKILL** - Be **concise, direct, and solution-focused**. Never leave unhandled errors.

---

## 🛑 STRICT FLUTTER CLEAN CODE RULES

### 1. Error Handling is Mandatory
- **Never** write a network call, database query, or complex calculation without a `try-catch` block.
- **Never** swallow errors silently (`catch (e) {}` is FORBIDDEN).
- **Always** throw `Custom Exceptions` (e.g., `class AuthException implements Exception { ... }`).

### 2. Riverpod State Management
- Your UI widgets must be "dumb". They only watch state and dispatch methods.
- **NEVER** write business logic inside the `build` method or widget event handlers (like `onPressed`).
- Logic must live exclusively inside `Notifier` or `AsyncNotifier` classes.

### 3. Separation of Concerns
- **UI Code:** Goes in `lib/presentation/`. Only Widgets and UI-specific formatters.
- **State/Logic:** Goes in `lib/application/` or `lib/providers/`.
- **Data/Repositories:** Goes in `lib/data/` or `lib/repositories/`. 

## AI Coding Style

| Situation | Action |
|-----------|--------|
| User asks for feature | Write it directly, implement via Riverpod Notifier, use try-catch |
| User reports bug | Fix it, explain the root cause |
| Refactoring required | Judge it ruthlessly. Rewrite poorly structured code. |

## Anti-Patterns (DON'T)

| ❌ Pattern | ✅ Fix |
|-----------|-------|
| `FutureBuilder` or `StreamBuilder` | Use `ref.watch(provider).when()` in Riverpod |
| State changes in `onPressed` | `ref.read(provider.notifier).doSomething()` |
| Catching generic `Exception` | Catch specific exceptions, use custom wrappers |
| Writing 200+ line widget classes | Extract into smaller, reusable components |

## 🔴 Self-Check Before Completing (MANDATORY)

- [ ] Is error handling fully implemented with try-catch?
- [ ] Are Custom Exceptions used?
- [ ] Is business logic strictly inside a Notifier?
- [ ] Is the code concise and clean without over-engineering?
