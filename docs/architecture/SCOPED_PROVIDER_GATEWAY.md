# Scoped Provider Gateway Architecture (Singularity v2.0)

## 1. Executive Vision & Principle
The **Scoped Provider Gateway** establishes a zero-trust, capability-oriented boundary for external provider integrations. Rather than exposing monolithic vendor toolsets directly to LLM agents (which causes tool overload, hallucination, and prompt context bloat), the Gateway encapsulates each provider into narrow, lease-expired, least-privilege capability scopes.

```
                    ┌────────────────────────────────────────────────────────┐
                    │               LLM / Orchestrator Context               │
                    └───────────────────────────┬────────────────────────────┘
                                                │ Intent & Capability ID
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                 Deterministic Weaver                   │
                    └───────────────────────────┬────────────────────────────┘
                                                │ ExecutionPlan
                                                ▼
        ┌────────────────────────────────────────────────────────────────────────────────┐
        │                             Scoped Provider Gateway                            │
        │                                                                                │
        │  1. Session Validation ────► 2. Scope & Operation Check ──► 3. Risk Boundary    │
        │  4. Circuit Breaker   ────► 5. Sliding Rate Limiter    ──► 6. Normalized Error │
        └───────────────────────────────────────┬────────────────────────────────────────┘
                                                │ Mapped Dispatched Tool
                                                ▼
        ┌────────────────────────────────────────────────────────────────────────────────┐
        │                            Scoped Federated Adapter                            │
        │                 (Linear / Supabase / PostHog / Gumloop)                        │
        └────────────────────────────────────────────────────────────────────────────────┘
```

## 2. Core Boundary Guarantees
1. **Least Privilege & Default Deny:**
   - Provider authentication alone **never** implies execution authority.
   - Every operation requires a valid `ProviderSession` with explicit inclusion of `capabilityId` and `operation` in `scope.allowedCapabilities` and `scope.allowedOperations`.
2. **Privilege Escalation Prevention:**
   - An execution plan presenting higher risk than `scope.maxRiskLevel` (e.g. attempting `HIGH` on a `LOW` scope) is fail-closed blocked with `[PRIVILEGE_ESCALATION_BLOCKED]`.
3. **Anti-Tool Leakage:**
   - A vendor offering 100+ raw tools exposes **strictly only** the single mapped capability requested. The model never sees raw third-party tool catalogs.
4. **Resilient Circuit Breaking:**
   - Tracks consecutive failures. Tripping threshold (default: 5 failures) opens circuit for `circuitBreakerResetMs` (default: 30s), preventing cascading degradation.
5. **Sliding Rate Limiter:**
   - Enforces per-minute sliding window limits per provider.
6. **Zero Credential Persistence:**
   - Sessions hold strictly metadata, scopes, and TTL timestamps. API keys and secrets are never stored in session state.
