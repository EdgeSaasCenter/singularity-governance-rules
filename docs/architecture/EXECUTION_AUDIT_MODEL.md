# Singularity Execution Audit Model & Correlation Engine (Singularity v2.0)

## 1. Formal Event Vocabulary

| Event Type | Emitted By | Purpose |
|---|---|---|
| `INTENT_RECEIVED` | Weaver / Gateway | Records incoming user intent and assigns root `executionId`. |
| `CAPABILITY_RESOLVED` | Resolver | Records formal capability lookup and dependency verification. |
| `POLICY_EVALUATED` | Policy Engine | Records gating verdict (Human Approval, Risk, Environment). |
| `PROVIDER_SELECTED` | Weaver Router | Records deterministic multi-axis scoring and candidate ranking. |
| `SESSION_CREATED` | Provider Gateway | Records leased session creation with fine-grained capability scope. |
| `EXECUTION_STARTED` | Provider Adapter | Records dispatch time, input digest, and execution parameters. |
| `EXECUTION_COMPLETED` | Provider Adapter | Records latency, output digest, and terminal success state. |
| `EXECUTION_FAILED` | Provider Adapter / Weaver | Records error code, sanitized error message, and failure diagnostics. |
| `FALLBACK_STARTED` | Weaver Router | Records fallback candidate activation upon primary failure. |
| `FALLBACK_COMPLETED` | Weaver Router | Records successful fallback execution outcome. |
| `RATE_LIMITED` | Provider Gateway | Records sliding rate limit threshold tripping. |
| `CIRCUIT_OPENED` | Provider Gateway | Records circuit breaker state transition to `OPEN`. |
| `LOOP_DETECTED` | Weaver Router | Records recursive or multi-hop capability cycle interception. |
| `AUTHENTICATION_CHANGED` | Provider Registry | Records credential status changes (`AUTHENTICATED`, `REVOKED`). |
| `HEALTH_CHANGED` | Provider Registry | Records provider health transitions (`HEALTHY`, `DEGRADED`, `UNHEALTHY`). |
| `EVIDENCE_WRITTEN` | Evidence Store | Records physical WAL write completion. |
| `EVIDENCE_VERIFIED` | Evidence Verifier | Records forensic audit verification result. |

## 2. Hierarchical Execution Tree (Correlation Model)
Distributed capability executions form nested acyclic trees:

```
[EXEC-ROOT] orchestrator.pipeline (depth: 0, status: SUCCESS)
    ├── [EXEC-CHILD-1] database.record.read (depth: 1, duration: 12.5ms, status: SUCCESS)
    └── [EXEC-CHILD-2] automation.pipeline.execute (depth: 1, status: SUCCESS)
            └── [EXEC-GRANDCHILD] system.write_evidence (depth: 2, status: SUCCESS)
```

The `EvidenceCorrelator` reconstructs this tree structure by linking:
- `intentId`
- `executionId`
- `parentExecutionId`
- `depth`
- `decisionId`
- `policyDecisionId`
- `sessionId`
- `status`
- `inputDigest` / `outputDigest`

## 3. EvidenceLevel Semantics

| Level | Description | Failure Behavior |
|---|---|---|
| `NONE` | No mandatory audit events (errors only). | Fail-Safe (Non-blocking) |
| `MINIMAL` | Lifecycle events only (`STARTED`, `COMPLETED`, `FAILED`). | Fail-Safe (Non-blocking) |
| `STANDARD` | Full lifecycle, routing scores, digests, and session leases. | Fail-Safe (Non-blocking) |
| `FORENSIC` | Complete cryptographic hash chain + mandatory WAL write. | **Fail-Closed** (Throws `AuditFailureError`) |
