# Singularity Evidence Fabric Architecture (Singularity v2.0)

## 1. Executive Mission & System Role
The **Singularity Evidence Fabric** is the physical cryptographic audit engine of the Singularity Workbench. It observes, normalizes, correlates, hashes, persists, and verifies every significant execution and routing decision across the platform without altering decision-making or exposing secrets.

```
                    ┌────────────────────────────────────────────────────────┐
                    │               LLM / Orchestrator Context               │
                    └───────────────────────────┬────────────────────────────┘
                                                │ Request / Intent
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                    Weaver Router                       │
                    └───────────────────────────┬────────────────────────────┘
                                                │ Emits Lifecycle Events
                                                ▼
        ┌────────────────────────────────────────────────────────────────────────────────┐
        │                            Singularity Evidence Fabric                         │
        │                                                                                │
        │  1. Pre-Hash Sanitizer ──► 2. SHA-256 Hasher ──► 3. Cryptographic Hash Chain   │
        │  4. Tree Correlator    ──► 5. SQLite Store   ──► 6. Forensic Verifier          │
        └───────────────────────────────────────┬────────────────────────────────────────┘
                                                │ Audited & Correlated Lineage
                                                ▼
        ┌────────────────────────────────────────────────────────────────────────────────┐
        │                            Amnesia DB (SQLite / WAL)                           │
        │            (evidence_events, evidence_chain_state, tasks, amnesia)             │
        └────────────────────────────────────────────────────────────────────────────────┘
```

## 2. Core Security Invariants
- **INVARIANT 1 (Zero Secret Persistence):** No API keys, passwords, JWTs, Bearer headers, or credentials are persisted.
- **INVARIANT 2 (Clean Event Preimage):** No secret appears in an `EvidenceEvent`.
- **INVARIANT 3 (Sanitization Before Hashing):** Hashes and digests are strictly computed *after* full sanitization.
- **INVARIANT 4 (Cryptographic Lineage):** Every event is cryptographically anchored to its predecessor:
  $$\text{eventHash}_i = \text{SHA256}(\text{canonical}(\text{payload}_i) \,\|\, \text{eventHash}_{i-1})$$
- **INVARIANT 5 (Hierarchical Correlation):** Child executions maintain explicit pointer to ancestor `parentExecutionId` and strict monotonic `depth`.
- **INVARIANT 6 (Tamper Detectability):** Any historical row alteration, deletion, reordering, or injection breaks the cryptographic chain and triggers forensic verification errors (`[HASH_MISMATCH]`, `[CHAIN_BREAK]`).
- **INVARIANT 7 (Fail-Closed / Fail-Safe Duality):**
  - Operations demanding `EvidenceLevel.FORENSIC` fail closed if evidence cannot be persisted.
  - Normal operations (`STANDARD`, `MINIMAL`) fail safe to preserve availability.

## 3. Cryptographic Append-Only Chain
- **Genesis Hash:** `0000000000000000000000000000000000000000000000000000000000000000` (64 zeros).
- **Deterministic Canonicalization:** Keys are lexicographically sorted at all depths; array element ordering is preserved; undefined properties are pruned.
- **Preimage Composition:**
  ```typescript
  const preimage = {
    ...canonicalPayload,
    previousEventHash
  };
  const eventHash = sha256(canonicalStringify(preimage));
  ```
