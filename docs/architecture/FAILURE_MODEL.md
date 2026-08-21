# Singularity Workbench — Unified Failure & Error Taxonomy (Phase 10)

## 1. Abstract & Principles

The **Singularity Failure Model** formalizes error classification, handling, and containment across the entire workbench runtime.

### Axioms:
1. **Typed Over Untyped:** Untyped JavaScript errors (`Error`, `string`) are strictly forbidden in production boundaries. Every error must instantiate `RuntimeError` with a defined category and code.
2. **Zero Secret Leakage:** Error messages, stack traces, and details dictionaries are scrubbed automatically upon instantiation.
3. **Fail-Closed by Default:** Security, validation, policy, and integrity violations MUST fail-closed.
4. **Resilient Fail-Open for Non-Security Internal Diagnostics:** Non-critical observability hooks degrade to log warnings without causing global system deadlocks (Law 10 & 11).

---

## 2. The 21 Canonical Error Categories

Location: `src/runtime/errors/errorTaxonomy.ts`

| # | Category | Description | Fail Policy | Default Severity |
|---|---|---|---|---|
| 1 | `VALIDATION` | Schema, type, or contract violation in inputs/outputs | Fail-Closed | `LOW` |
| 2 | `AUTHENTICATION` | Missing, expired, or invalid credentials | Fail-Closed | `HIGH` |
| 3 | `AUTHORIZATION` | Insufficient role, token scope, or permission | Fail-Closed | `HIGH` |
| 4 | `POLICY` | Rejection by governance rules or missing explicit approval | Fail-Closed | `HIGH` |
| 5 | `DISCOVERY` | Failure during candidate manifest ingestion or parsing | Fail-Closed | `MEDIUM` |
| 6 | `VERIFICATION` | Failure across any of the 8 verification axes | Fail-Closed | `HIGH` |
| 7 | `LIFECYCLE` | Illegal state jump (e.g. `DISCOVERED` $\to$ `ENABLED`) | Fail-Closed | `HIGH` |
| 8 | `HEALTH` | Provider probe timeout or consecutive health check failures | Degrade/Failover | `MEDIUM` |
| 9 | `ROUTING` | No candidate provider available or routing score collapse | Fail-Closed / Fallback | `MEDIUM` |
| 10 | `RATE_LIMIT` | Quota exceeded on scoped provider gateway | Throttle / Retry | `LOW` |
| 11 | `CIRCUIT_BREAKER` | Gateway tripped due to consecutive provider errors | Fast-Fail / Fallback | `HIGH` |
| 12 | `ADAPTER` | Physical execution failure within native or federated adapter | Fallback Candidate | `HIGH` |
| 13 | `NETWORK` | Socket timeout, connection reset, or DNS resolution failure | Retryable / Fallback | `HIGH` |
| 14 | `TIMEOUT` | In-flight deadline budget expired | Fail-Closed | `HIGH` |
| 15 | `CANCELLATION` | Explicit cancellation signal triggered by operator/parent | Abort-Immediate | `LOW` |
| 16 | `PERSISTENCE` | SQLite lock, disk I/O failure, or table corruption | Fail-Closed (Forensic) | `CRITICAL` |
| 17 | `EVIDENCE` | Tampered event hash, broken correlation chain, or missing ref | Fail-Closed | `CRITICAL` |
| 18 | `MEMORY` | Poisoned prompt injection, illegal rule claim, or out-of-range confidence | Intercept & Block | `HIGH` |
| 19 | `REPLAY` | Historical verification divergence detected during read-only audit | Flag Divergence | `MEDIUM` |
| 20 | `SECURITY` | Injection attack, path traversal, or privilege escalation | Fail-Closed & Alert | `CRITICAL` |
| 21 | `INTEGRITY` | Cryptographic signature or content-digest mismatch | Fail-Closed & Lock | `FATAL` |

---

## 3. Standard Error Codes

```typescript
export enum StandardErrorCode {
  SCHEMA_VALIDATION_FAILED = "SCHEMA_VALIDATION_FAILED",
  CAPABILITY_NOT_FOUND = "CAPABILITY_NOT_FOUND",
  NO_HEALTHY_PROVIDER = "NO_HEALTHY_PROVIDER",
  ALL_PROVIDERS_FAILED = "ALL_PROVIDERS_FAILED",
  POLICY_VIOLATION = "POLICY_VIOLATION",
  APPROVAL_REQUIRED = "APPROVAL_REQUIRED",
  AUTHENTICATION_REQUIRED = "AUTHENTICATION_REQUIRED",
  SCOPE_VIOLATION = "SCOPE_VIOLATION",
  TIMEOUT_EXPIRED = "TIMEOUT_EXPIRED",
  EXECUTION_CANCELLED = "EXECUTION_CANCELLED",
  RATE_LIMIT_EXCEEDED = "RATE_LIMIT_EXCEEDED",
  CIRCUIT_BREAKER_OPEN = "CIRCUIT_BREAKER_OPEN",
  ADAPTER_EXECUTION_FAILED = "ADAPTER_EXECUTION_FAILED",
  NETWORK_UNAVAILABLE = "NETWORK_UNAVAILABLE",
  PERSISTENCE_FAILED = "PERSISTENCE_FAILED",
  EVIDENCE_TAMPERED = "EVIDENCE_TAMPERED",
  MEMORY_POISONED = "MEMORY_POISONED",
  REPLAY_DIVERGENCE = "REPLAY_DIVERGENCE",
  SECURITY_VIOLATION = "SECURITY_VIOLATION",
  DEPTH_OVERFLOW = "DEPTH_OVERFLOW",
  RECURSION_CYCLE_DETECTED = "RECURSION_CYCLE_DETECTED",
  ILLEGAL_LIFECYCLE_TRANSITION = "ILLEGAL_LIFECYCLE_TRANSITION",
  INTERNAL_ERROR = "INTERNAL_ERROR"
}
```

---

## 4. Automatic Secret Scrubbing Architecture

When any `RuntimeError` is instantiated:
1. The error `message` string is scrubbed against regex patterns for API keys, Bearer tokens, JWTs, and RSA headers.
2. The `details` object is recursively traversed, redacting matching values to `[REDACTED_SECRET]`.
3. `toEvidencePayload()` formats safe, sanitized error diagnostics for persistence into the SQLite evidence chain.
