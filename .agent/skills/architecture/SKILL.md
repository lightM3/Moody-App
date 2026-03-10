---
name: architecture
description: Architectural decision-making framework for Flutter using Riverpod.
allowed-tools: Read, Glob, Grep
---

# Architecture Decision Framework (Flutter/Riverpod)

> "Widgets consume. Notifiers produce. Repositories fetch."

## 🎯 Architecture Paradigm

This project strictly adheres to a scalable, layered architecture driven by **Riverpod**.

### 1. Presentation Layer (UI)
- Contains ONLY Flutter widgets.
- Interacts with state via `ref.watch()` or `ref.read()`.
- Knows absolutely nothing about data fetching, APIs, or Supabase.

### 2. Application Layer (State/Logic)
- Contains `Notifier` and `AsyncNotifier` classes.
- This is the "Brain". It reacts to user intent, processes rules, handles loading/error states, and updates the state.
- **Rule:** If it requires `if/else` logic based on user data, it belongs here.

### 3. Data Layer (Repositories & Services)
- Contains classes that interact with the external world (Supabase, local storage, APIs).
- Must strictly use `try-catch` blocks.
- Must map generic external exceptions to **Custom Domain Exceptions**.

---

## Validation Checklist

Before finalizing architecture for a new feature:

- [ ] Is the business logic completely extracted from the UI?
- [ ] Is the State Management handled exclusively by Riverpod?
- [ ] Are external data calls abstracted behind a Repository class?
- [ ] Do repository methods handle exceptions properly and throw Custom Exceptions?
