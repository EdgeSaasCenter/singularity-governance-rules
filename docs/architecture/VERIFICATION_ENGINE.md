# Singularity Architecture — 8-Axis Verification Engine

## 1. Executive Summary & Verification Axioms

The Verification Engine enforces an immutable 8-axis gate before any discovered provider or capability can transition to an operational state.

### Invariant Principles
- **Registration $\neq$ Verification:** Inserting a candidate into memory does not verify its operational integrity.
- **Verification $\neq$ Authorization:** A verified capability still requires contextual Policy Engine evaluation before execution.
- **NOT_VERIFIABLE is Fail-Closed:** If any axis cannot be physically confirmed (e.g., missing runtime adapter, unreachable socket, unverifiable credentials), the candidate receives `NOT_VERIFIABLE` and CANNOT transition to `VERIFIED`.

---

## 2. The 8 Orthogonal Verification Axes

```
                                  ┌────────────────────────┐
                                  │   Candidate Intake     │
                                  └───────────┬────────────┘
                                              │
    ┌─────────────────────────────────────────┼─────────────────────────────────────────┐
    │                                         │                                         │
┌───▼───────────────┐               ┌─────────▼─────────┐               ┌───────────────▼───┐
│ 1. IDENTITY AXIS  │               │ 2. TRANSPORT AXIS │               │  3. SCHEMA AXIS   │
│ ID, Version, Name │               │ Native, MCP, HTTP │               │ Contracts, SemVer │
└───┬───────────────┘               └─────────┬─────────┘               └───────────────┬───┘
    │                                         │                                         │
    │                               ┌─────────▼─────────┐                               │
    ├──────────────────────────────►│ 4. ADAPTER AXIS   │◄──────────────────────────────┤
    │                               │ Physical Adapter  │                               │
    │                               └─────────┬─────────┘                               │
    │                                         │                                         │
┌───▼───────────────┐               ┌─────────▼─────────┐               ┌───────────────▼───┐
│  5. HEALTH AXIS   │               │   6. AUTH AXIS    │               │  7. SCOPE AXIS    │
│ Active Telemetry  │               │ Token / Creds     │               │ Risk & Governance │
└───┬───────────────┘               └─────────┬─────────┘               └───────────────┬───┘
    │                                         │                                         │
    └─────────────────────────────────────────┼─────────────────────────────────────────┘
                                              │
                                    ┌─────────▼─────────┐
                                    │ 8. DEPENDENCIES   │
                                    │   DAG Resolution  │
                                    └─────────┬─────────┘
                                              │
                                    ┌─────────▼─────────┐
                                    │ VerificationVerdict│
                                    │VERIFIED / REJECTED│
                                    └───────────────────┘
```

### Axis Verification Criteria Matrix
| # | Axis | Target Check | Failure Diagnostic |
|---|---|---|---|
| 1 | **Identity** | Provider and capability ID, name, version format | `IDENTITY_INVALID` |
| 2 | **Transport** | Compatible transport protocol between provider and caps | `TRANSPORT_UNSUPPORTED` |
| 3 | **Schema** | Zod contract parse and metadata integrity | `SCHEMA_MALFORMED` |
| 4 | **Adapter** | Physical registered adapter initialized in ProviderRegistry | `ADAPTER_NOT_FOUND` |
| 5 | **Health** | Provider reported health must not be `UNHEALTHY` or `DEGRADED` | `HEALTH_CHECK_FAILED` |
| 6 | **Auth** | Credentials verified or token state must not be `REVOKED` | `AUTH_UNVERIFIABLE` |
| 7 | **Scope** | Capabilities must conform to global policy boundaries | `SCOPE_EXCEEDED` |
| 8 | **Dependencies** | All declared dependencies must resolve without cycles | `DEPENDENCY_UNRESOLVED` |

---

## 3. Verdict Determination & Cryptographic Digest

The overall verdict is calculated via strict predicate logic:
- **`VERIFIED`**: All 8 axes evaluate to `true`.
- **`REJECTED`**: Any axis fails due to explicit rejection (unhealthy provider, revoked auth, circular dependency).
- **`NOT_VERIFIABLE`**: Adapter is absent or auth state is unverified/discovered.

```typescript
const verificationDigest = computeDigest({
  providerId: candidate.provider.identity.id,
  verdict,
  axes,
  diagnostics,
  verifiedAt
});
```

The SHA-256 digest is cryptographically attached to the lifecycle transition and evidence record.
