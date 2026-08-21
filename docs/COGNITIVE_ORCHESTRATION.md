# Singularity Cognitive Orchestration Architecture (Singularity v2.0)

## 1. Executive Purpose & Causal Pipeline
The **Singularity Cognitive Orchestrator** closes the causal execution loop of the Singularity Workbench, coordinating memory understanding, policy gating, deterministic capability resolution, Weaver routing, evidence auditing, and learning:

$$\text{INTENT} \;\longrightarrow\; \text{CONTEXT} \;\longrightarrow\; \text{DECISION} \;\longrightarrow\; \text{EXECUTION} \;\longrightarrow\; \text{EVIDENCE} \;\longrightarrow\; \text{LEARNING} \;\longrightarrow\; \text{NEXT CONTEXT}$$

```
                    ┌────────────────────────────────────────────────────────┐
                    │                      User Intent                       │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │               Cognitive Context Assembly               │
                    │      (MemoryStore + SemanticIndex + ProceduralRules)   │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │               Context-Aware Policy Engine              │
                    │        (Governance Constraints & Conflict Gating)      │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                      Weaver Router                     │
                    │        (Deterministic Candidate Scoring & Fallback)    │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                 Real Provider Execution                │
                    │           (Scoped Gateway & Physical Adapters)         │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                     Evidence Fabric                    │
                    │       (SHA-256 Hash Chain & Execution Correlation)     │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │               Closed-Loop Outcome Processor            │
                    │          (Poisoning Defense & Memory Feedback)         │
                    └────────────────────────────────────────────────────────┘
```

## 2. Core Invariants & Separation of Authority
- **INVARIANT 1 (Context Is Not Privilege):** Semantic memory provides context, but can never escalate permissions, bypass policy rules, or authorize destructive actions.
- **INVARIANT 2 (Governance Superiority):** Procedural governance rules (`.agents/rules/`) have absolute precedence (`confidence: 1.0`). If a constitutional rule prohibits an action, policy denies execution fail-closed.
- **INVARIANT 3 (Anti-Loop & Depth Bounds):** Direct recursion ($A \to A$), multi-hop cycles ($A \to B \to A$), and executions exceeding `maxDepth: 10` are intercepted before invocation.
- **INVARIANT 4 (Zero Secret Leakage):** Secrets and tokens (`sk-live-...`, JWTs) are sanitized prior to trace calculation, evidence recording, and memory updates.
- **INVARIANT 5 (Reproducible Deterministic Replay):** Decisions produce a canonical `DecisionTrace` with SHA-256 `traceDigest`. Replay is strictly READ-ONLY.

## 3. Orchestration Stages

| Stage | Action & Component | Terminal State on Failure |
|---|---|---|
| `INITIATED` | Request validation & callStack check | `CYCLE_DETECTED` / `DEPTH_EXCEEDED` |
| `CONTEXT_ASSEMBLED` | 8-stage memory retrieval & context assembly | `UNKNOWN_STATE` |
| `CAPABILITY_RESOLVED`| Capability lookup in CapabilityRegistry | `CAPABILITY_NOT_FOUND` |
| `POLICY_EVALUATED` | Context-aware policy evaluation | `POLICY_DENIED` |
| `ROUTE_SELECTED` | Weaver scoring and fallback candidate chain | `NO_PROVIDER_AVAILABLE` |
| `EXECUTING` | Adapter physical invocation | `EXECUTION_FAILED` |
| `EVIDENCED` | Evidence event emission to EvidenceStore | `AUDIT_FAILURE` |
| `LEARNED` | Outcome processing into MemoryStore | `POISONING_BLOCKED` |
