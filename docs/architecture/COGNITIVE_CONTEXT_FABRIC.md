# Singularity Cognitive Context Fabric Architecture (Singularity v2.0)

## 1. Executive Purpose & Architectural Boundary
The **Singularity Cognitive Context Fabric** bridges raw stored memory and real-time execution decision-making. Its fundamental mission is answering:

> **"What does the system need to know RIGHT NOW to make an optimal, secure, and compliant decision?"**

without dumping unbound memory buffers into LLM context windows or confusing memory with objective truth.

```
                    ┌────────────────────────────────────────────────────────┐
                    │                      User Intent                       │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
  ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
  │                              Cognitive Context Pipeline                                       │
  │                                                                                               │
  │  1. Retrieve Candidates ──► 2. Scope & Status Filter ──► 3. Freshness Decay                   │
  │  4. Evidence Weighting  ──► 5. Deduplication         ──► 6. Ranking Score                     │
  │  7. Conflict Detection  ──► 8. Budget Packing        ──► 9. Digest (SHA-256)                  │
  └─────────────────────────────────────────────┬─────────────────────────────────────────────────┘
                                                │ Bounded, Verified CognitiveContext
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                     Policy Engine                      │
                    └───────────────────────────┬────────────────────────────┘
                                                │ Gated Intent
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                     Weaver Router                      │
                    └───────────────────────────┬────────────────────────────┘
                                                │ Routed Plan
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                     Physical Execution                 │
                    └────────────────────────────────────────────────────────┘
```

## 2. Core Invariants & Separation of Authority
- **INVARIANT 1 (MEMORY $\neq$ TRUTH):** Stored memory is treated as subjective data until corroborated by cryptographic evidence from the Evidence Fabric or constitutional governance rules.
- **INVARIANT 2 (Memory Does Not Decide):** Memory provides structured, bounded context. Routing decisions belong strictly to `Policy Engine` $\to$ `CapabilityResolver` $\to$ `WeaverRouter`.
- **INVARIANT 3 (Governance Superiority):** Governance rules (`.agents/rules/`) possess absolute authority (`confidence: 1.0`, `contentType: "RULE"`). Semantic memories can never override or contradict procedural rules.
- **INVARIANT 4 (Explicit Conflict Representation):** Contradictory assertions are explicitly surfaced as `CONFLICTED` uncertainties with evidence-backed precedence, never silently resolved by dropping one side.
- **INVARIANT 5 (Reproducible Context Digest):** Every assembled `CognitiveContext` calculates a deterministic 64-character SHA-256 `contextDigest` of its canonical preimage.

## 3. Cognitive Context Bins

| Context Field | Class / Source | Description |
|---|---|---|
| `currentState` | System / Session | Volatile runtime environment, tenant identity, execution variables. |
| `relevantFacts` | Semantic / Episodic | High-confidence domain concepts, verified summaries, external facts. |
| `recentEvents` | Episodic / Evidence | Recent execution events and observations from `EvidenceStore`. |
| `activeTasks` | Working / TaskQueue | Active, pending, or recently failed tasks in flight. |
| `applicableRules` | Procedural / Governance | Constitutional rules loaded from `.agents/rules/`. |
| `relevantEvidence` | Evidence Fabric | Cryptographic event IDs backing cited assertions. |
| `uncertainties` | Dynamic Evaluation | Explicit unknown or uncorroborated domains (`UNKNOWN`, `NOT_VERIFIABLE`). |
| `conflicts` | Conflict Detector | Contradictory assertion pairs with confidence delta and preferred record. |
