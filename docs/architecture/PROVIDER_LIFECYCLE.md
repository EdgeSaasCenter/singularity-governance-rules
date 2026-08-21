# Singularity Architecture — Provider Lifecycle State Machine

## 1. Executive Summary & Lifecycle Invariants

The Provider Lifecycle State Machine enforces a unidirectional, monotonic progression through operational states, preventing unverified execution and governing state degradation and revocation.

### Constitutional Invariants
- **Progressive Activation Only:** Direct jumps from `UNKNOWN` or `DISCOVERED` directly to `VERIFIED` are strictly prohibited and throw `ILLEGAL_LIFECYCLE_TRANSITION`.
- **Revocation is Terminal:** Once a provider is in `REVOKED` state, it cannot be un-revoked or transitioned to `VERIFIED` without creating a new cryptographic identity.
- **Fail-Closed Degradation:** Consecutive execution failures automatically degrade and disable providers to protect workbench stability.

---

## 2. Finite State Machine (FSM) Transition Diagram

```
      ┌──────────┐
      │ UNKNOWN  │
      └────┬─────┘
           │ (1) Discover
           ▼
     ┌────────────┐
     │ DISCOVERED │
     └─────┬──────┘
           │ (2) Configure
           ▼
     ┌────────────┐
     │ CONFIGURED │
     └─────┬──────┘
           │ (3) Authenticate
           ▼
    ┌───────────────┐
    │ AUTHENTICATED │
    └──────┬────────┘
           │ (4) 8-Axis Verify
           ▼
     ┌────────────┐           (5) Failures >= 3           ┌──────────┐
     │  VERIFIED  ├──────────────────────────────────────►│ DEGRADED │
     └─────┬──────┤                                       └────┬─────┘
           │      │◄───────────────────────────────────────────┤
           │      │              (6) Probe Recovers            │
           │      │                                            │ (7) Failures >= 5
           │      │                                            ▼
           │      │                                       ┌──────────┐
           │      └──────────────────────────────────────►│ DISABLED │
           │                                              └────┬─────┘
           │                                                   │
           │ (8) Security / Integrity Breach                   │ (8)
           ▼                                                   ▼
     ┌───────────────────────────────────────────────────────────────┐
     │                            REVOKED                            │
     │                      (Terminal State)                         │
     └───────────────────────────────────────────────────────────────┘
```

---

## 3. Canonical Transition Matrix (`LEGAL_LIFECYCLE_TRANSITIONS`)

```typescript
export const LEGAL_LIFECYCLE_TRANSITIONS: Record<CapabilityStatus, CapabilityStatus[]> = {
  [CapabilityStatus.UNKNOWN]: [
    CapabilityStatus.DISCOVERED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.DISCOVERED]: [
    CapabilityStatus.CONFIGURED,
    CapabilityStatus.DISABLED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.CONFIGURED]: [
    CapabilityStatus.AUTHENTICATED,
    CapabilityStatus.DISABLED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.AUTHENTICATED]: [
    CapabilityStatus.VERIFIED,
    CapabilityStatus.DISABLED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.VERIFIED]: [
    CapabilityStatus.DEGRADED,
    CapabilityStatus.DISABLED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.DEGRADED]: [
    CapabilityStatus.VERIFIED,
    CapabilityStatus.DISABLED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.DISABLED]: [
    CapabilityStatus.DISCOVERED,
    CapabilityStatus.REVOKED
  ],
  [CapabilityStatus.REVOKED]: [] // Terminal State — No outgoing transitions
};
```

---

## 4. Operational Health Monitor Thresholds

`ProviderHealthMonitor` maintains in-flight telemetry and triggers automated FSM transitions:
1. **Threshold 3 Consecutive Failures:**
   - Automatically transitions provider from `VERIFIED` $\to$ `DEGRADED`.
   - Emits `HEALTH_CHANGED` evidence event.
2. **Threshold 5 Consecutive Failures:**
   - Automatically transitions provider from `DEGRADED` $\to$ `DISABLED`.
   - Blocks Weaver and Resolver from selecting provider.
3. **Recovery on Success:**
   - Upon a successful execution, resets consecutive failure counter to 0 and restores health to `HEALTHY`.
