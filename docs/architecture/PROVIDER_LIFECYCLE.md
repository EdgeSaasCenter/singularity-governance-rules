# Singularity Workbench — Provider Lifecycle State Machine
**Phase 9 Subsystem Architecture | FSM Formal Specification & Revocation Contract**

---

## 1. Canonical Finite State Machine (FSM)

The lifecycle of an execution provider in the Singularity Runtime is governed by an explicit, finite state machine implemented in `ProviderLifecycleManager`. State transitions cannot occur implicitly, and illegal skips are rejected fail-closed with immediate security audit warnings.

```
                   ┌──────────┐
                   │ UNKNOWN  │
                   └────┬─────┘
                        │
                        ▼
                 ┌──────────────┐
                 │  DISCOVERED  ├───────────────────────────────┐
                 └──────┬───────┘                               │
                        │                                       │
                        ▼                                       │
                 ┌──────────────┐                               │
                 │  CONFIGURED  ├─────────────────────────┐     │
                 └──────┬───────┘                         │     │
                        │                                 │     │
                        ▼                                 │     │
               ┌─────────────────┐                        │     │
               │  AUTHENTICATED  ├───────────────────┐    │     │
               └────────┬────────┘                   │    │     │
                        │                            │    │     │
                        ▼                            │    │     │
                 ┌──────────────┐                    │    │     │
        ┌───────►│   VERIFIED   ├──────────────┐     │    │     │
        │        └──────┬───────┘              │     │    │     │
        │ (Healed)      │ (Degraded)           ▼     ▼    ▼     ▼
        │               ▼                 ┌────────────────────┐
        └─────────┌────────────┐          │      DISABLED      │
                  │  DEGRADED  ├─────────►│                    │
                  └────────────┘          └─────────┬──────────┘
                                                    │
                                                    ▼
                                          ┌────────────────────┐
                                          │      REVOKED       │ ◄── [TERMINAL STATE]
                                          └────────────────────┘
```

---

## 2. Formal Transition Matrix

| From State | Allowed Target States | Enforcement Policy |
| :--- | :--- | :--- |
| `UNKNOWN` | `DISCOVERED` | Initial candidate parsing from approved discovery source. |
| `DISCOVERED` | `CONFIGURED`, `DISABLED`, `REVOKED` | Manifest validated; circular dependencies checked. |
| `CONFIGURED` | `AUTHENTICATED`, `DISABLED`, `REVOKED` | Transport credentials, scopes, and keys verified. |
| `AUTHENTICATED` | `VERIFIED`, `DEGRADED`, `DISABLED`, `REVOKED` | Full 8-axis verification completed successfully. |
| `VERIFIED` | `DEGRADED`, `DISABLED`, `REVOKED` | Runtime operational monitoring or security revocation. |
| `DEGRADED` | `VERIFIED`, `DISABLED`, `REVOKED` | Success threshold recovered or consecutive failures escalated. |
| `DISABLED` | `CONFIGURED`, `AUTHENTICATED`, `VERIFIED`, `REVOKED` | Administrative intervention or diagnostic check passed. |
| `REVOKED` | *(None — Terminal)* | Irrevocable state due to compromise, tamper, or policy ban. |

---

## 3. Dynamic Health Monitoring & Graceful Degradation

The `ProviderHealthMonitor` executes real-time operational health checks:
- **Success Tracking:** Records latency and increments operational success counters, resetting consecutive failure metrics.
- **Degradation Threshold ($N \ge 3$ consecutive failures):** Transitions provider from `VERIFIED` $\to$ `DEGRADED`. The `WeaverRouter` continues to evaluate the provider but penalizes its routing score, prioritizing healthy secondary candidates.
- **Disablement Threshold ($N \ge 5$ consecutive failures):** Transitions provider from `DEGRADED` $\to$ `DISABLED`. The provider is immediately pruned from the active candidate pool.
- **Autonomous Recovery:** If a subsequent health check probe succeeds, the provider recovers from `DEGRADED` $\to$ `VERIFIED`.

---

## 4. Immediate Audited Revocation

The `RevocationManager` handles audited security revocations:
- **Supported Revocation Reasons:** `SECURITY`, `AUTH_REVOKED`, `PROVIDER_INVALID`, `MANIFEST_TAMPERING`, `POLICY`, `ADMINISTRATIVE`, `INTEGRITY_FAILURE`.
- **Immediate Registry Invalidation:** Updates `ProviderRegistry` and `CapabilityRegistry` to status `REVOKED` and health `DISABLED`.
- **Weaver Routing Exclusion:** The `WeaverRouter` and `CapabilityResolver` strictly fail-closed (`ALL_PROVIDERS_DISABLED`) if a request attempts to invoke a revoked provider.
- **Evidence Emission:** Emits an immutable `EvidenceEventType.CIRCUIT_OPENED` cryptographic event into the Evidence Store with full forensic correlation.
