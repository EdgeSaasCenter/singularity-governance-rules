# Singularity Architecture — Provider Revocation & Invalidation

## 1. Executive Summary & Revocation Guarantees

Revocation is an immediate, audited, and irrevocable action that terminates a provider's operational authority across all workbench subsystems.

### Core Guarantees
- **Atomic Subsystem Invalidation:** Revoking a provider atomically updates the `ProviderRegistry` (status $\to$ `REVOKED`, authStatus $\to$ `REVOKED`, healthStatus $\to$ `DISABLED`), invalidates all provided capabilities in `CapabilityRegistry`, and forces the `ProviderLifecycleManager` into the `REVOKED` state.
- **Fail-Closed Execution Gating:** `CapabilityResolver` and `WeaverRouter` strictly exclude revoked providers from execution plan generation and routing fallback pools.
- **Immutable Evidence Logging:** Emits `REVOCATION_REQUESTED` and `REVOCATION_COMPLETED` cryptographic evidence events with causation details and actor identity.
- **Semantic Memory Warning Injection:** Automatically generates a high-confidence security alert memory entry to ensure downstream cognitive planning engines avoid revoked dependencies.

---

## 2. Revocation Taxonomy (`RevocationReason`)

```typescript
export enum RevocationReason {
  SECURITY = "SECURITY",                         // Secret leak, malware, malicious payload
  AUTH_REVOKED = "AUTH_REVOKED",                 // Upstream API key/token invalidated
  PROVIDER_INVALID = "PROVIDER_INVALID",         // Behavioral failure or malformed payload
  MANIFEST_TAMPERING = "MANIFEST_TAMPERING",     // Cryptographic digest mismatch or schema alteration
  POLICY = "POLICY",                             // Governance rule or boundary violation
  ADMINISTRATIVE = "ADMINISTRATIVE",             // Manual operator deprecation
  INTEGRITY_FAILURE = "INTEGRITY_FAILURE"        // Evidence chain or hash failure
}
```

---

## 3. Revocation Sequence Workflow

```
 ┌───────────────────────┐
 │ Revocation Request    │
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 1. Emit Evidence      │──► EvidenceStore: REVOCATION_REQUESTED
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 2. Lifecycle FSM      │──► Transition provider -> REVOKED
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 3. Registry Update    │──► ProviderRegistry: status=REVOKED, authStatus=REVOKED
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 4. Capability Update  │──► CapabilityRegistry: availability.status=REVOKED
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 5. Semantic Memory    │──► MemoryStore: category=OBSERVATION, tag=security_alert
 └───────────┬───────────┘
             │
             ▼
 ┌───────────────────────┐
 │ 6. Audit Trail Seal   │──► EvidenceStore: REVOCATION_COMPLETED (SHA-256 chained)
 └───────────────────────┘
```

---

## 4. Adversarial Protection Against Revocation Bypass

- **No Fallback Selection:** When a primary provider fails, `WeaverRouter` evaluates alternative providers. Revoked providers are strictly filtered out from the fallback pool.
- **No In-Memory Resurrection:** Any attempt to re-register a revoked provider ID via `ProviderRegistry.register()` throws duplicate registration errors, and `ProviderLifecycleManager.transition()` rejects any forward transition from `REVOKED`.
