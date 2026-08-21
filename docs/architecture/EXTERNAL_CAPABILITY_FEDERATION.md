# External Capability Federation Architecture (Singularity v2.0)

## 1. Federation Lifecycle
Every external vendor integration in Singularity must conform to the 8-stage canonical lifecycle:

$$\text{DISCOVERY} \longrightarrow \text{NORMALIZATION} \longrightarrow \text{REGISTRATION} \longrightarrow \text{POLICY} \longrightarrow \text{SCOPING} \longrightarrow \text{WEAVER} \longrightarrow \text{ADAPTER} \longrightarrow \text{EXECUTION} \longrightarrow \text{EVIDENCE}$$

1. **Discovery:** Introspect vendor API metadata and transport mechanics.
2. **Normalization:** Map external vendor tool definitions to canonical domain capabilities (`CapabilityNormalizer`).
3. **Registration:** Register vendor manifest in `CapabilityRegistry`, `ProviderRegistry`, and `ScopedProviderGateway`.
4. **Policy:** Evaluate security constraints, human approval flags, and environment tiers (`PolicyEvaluator`).
5. **Scoping:** Generate a cryptographically unique `ProviderSession` with fine-grained capability leases.
6. **Weaver Routing:** Deterministically calculate multi-axis provider scoring and tie-breaking.
7. **Scoped Adapter:** Securely isolate environment variables and dispatch normalized payloads.
8. **Evidence & WAL:** Produce immutable execution evidence with sanitized secrets and record transactional WAL entries.

## 2. Priority Federated Manifests

| Provider | Canonical Capabilities | Vendor Dispatched Tools | Transport | Risk | Evidence Required |
|---|---|---|---|---|---|
| **Linear** | `project.issue.read`<br>`project.issue.create`<br>`project.issue.update` | `linear_get_issue`<br>`linear_create_issue`<br>`linear_update_issue` | `REST_API` | `ZERO`<br>`LOW`<br>`LOW` | No<br>Yes<br>Yes |
| **Supabase** | `database.record.read`<br>`database.record.write`<br>`database.schema.inspect` | `supabase_select`<br>`supabase_insert`<br>`supabase_introspect` | `REST_API` | `ZERO`<br>`MEDIUM`<br>`ZERO` | No<br>Yes<br>No |
| **PostHog** | `analytics.event.capture`<br>`analytics.insight.query` | `posthog_capture_event`<br>`posthog_query_insights` | `REST_API` | `ZERO`<br>`ZERO` | Yes<br>No |
| **Gumloop** | `automation.pipeline.execute`<br>`automation.pipeline.status` | `gumloop_run_pipeline`<br>`gumloop_get_status` | `REST_API` | `MEDIUM`<br>`ZERO` | Yes<br>No |

## 3. Strict Verification Invariant (Anti-Falsification)
If environment credentials (e.g. `LINEAR_API_KEY`, `SUPABASE_KEY`) are missing, adapters must return:
- `HealthStatus.UNKNOWN` with `verificationStatus: "NOT_VERIFIABLE"`
- `AuthStatus.DISCOVERED` with `authenticated: false`

The Singularity Workbench strictly forbids falsifying success or mocking connected states when physical credentials are unavailable.
