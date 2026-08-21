# Singularity Workbench — Autonomous Capability Discovery Specification
**Phase 9 Subsystem Architecture | Security & Protocol Contract**

---

## 1. Architectural Philosophy: Discovery ≠ Trust

In traditional dynamic runtime environments, service discovery often implicitly implies trust: a discovered endpoint is immediately added to the routing table and queried. In **The Singularity Workbench**, this implicit trust model is rejected as an unacceptably vulnerable security hazard.

$$\text{DISCOVERY} \neq \text{TRUST}$$
$$\text{OBSERVATION} \neq \text{AUTHORITY}$$
$$\text{HEALTH} \neq \text{TRUST}$$
$$\text{REGISTRATION} \neq \text{VERIFICATION}$$
$$\text{VERIFICATION} \neq \text{AUTHORIZATION}$$

An external candidate provider discovered from a local manifest, MCP server descriptor, OpenAPI spec, or configuration file is fundamentally treated as an **untrusted observation**. Discovery is strictly read-only and analytical:
1. **Zero Execution of Arbitrary Code:** The Discovery Engine is prohibited from running unverified binaries, arbitrary shell commands, or dynamic `eval` statements during the discovery and probing phases.
2. **Metadata Sanitization:** All discovered descriptors and configuration payloads pass through mandatory secret sanitization (`sanitizeSecrets`), redacting API keys, bearer tokens, passwords, and private keys before any in-memory persistence or logging.
3. **Fail-Closed Gateways:** Discovered capabilities remain isolated in state `DISCOVERED` and are excluded from the `WeaverRouter` operational routing table until the full 8-axis `VerificationEngine` awards a verdict of `VERIFIED`.

---

## 2. Discovery Source Taxonomies

The Singularity Discovery Layer accepts candidate descriptors strictly through typed, authenticated channels:

```
                  ┌────────────────────────┐
                  │ DiscoverySourceSchema  │
                  └───────────┬────────────┘
                              │
       ┌──────────────────────┼──────────────────────┐
       │                      │                      │
┌──────▼────────┐      ┌──────▼───────┐      ┌───────▼────────┐
│ LOCAL_MANIFEST│      │  MCP_SERVER  │      │REST_DESCRIPTOR │
└───────────────┘      └──────────────┘      └────────────────┘
       │                      │                      │
┌──────▼────────┐      ┌──────▼───────┐      ┌───────▼────────┐
│ CONFIGURATION │      │REGISTERED_...│      │ MANUAL_DECLAR. │
└───────────────┘      └──────────────┘      └────────────────┘
```

| Source Type | Verification Invariant | Execution Privilege |
| :--- | :--- | :--- |
| `LOCAL_MANIFEST` | Cryptographic hash & schema match | Native / Subprocess (Sandboxed) |
| `MCP_SERVER` | Protocol handshake & capability probe | JSON-RPC over STDIO / SSE |
| `REST_DESCRIPTOR` | OpenAPI 3.x schema & scope audit | Scoped HTTP Adapter |
| `GRAPHQL_SCHEMA` | AST introspection & query depth limits | Scoped HTTP Adapter |
| `CONFIGURATION` | Immutable environment / config binding | Read-Only Runtime Config |
| `REGISTERED_PROVIDER` | Historical registration re-evaluation | Re-verification & Dynamic Health |
| `MANUAL_DECLARATION` | Explicit administrator signature | Audited Human Elevation |

---

## 3. End-to-End Discovery Pipeline

The discovery lifecycle advances deterministically through discrete cognitive and operational gates:

```
[Candidate Source]
       │
       ▼
[1. Manifest Validator] ──(Invalid / Circular)──► [REJECTED (Fail-Closed)]
       │ (Valid & Sanitized)
       ▼
[2. Non-Destructive Probing]
       ├─ ProviderProbe (Identity, Transport, Health, Auth)
       └─ CapabilityProbe (Domain, Operation, Risk, Approval)
       │
       ▼
[3. 8-Axis Verification Engine] ──(Missing Adapter / Unverified Auth)──► [NOT_VERIFIABLE]
       │ (100% Passed)
       ▼
[4. Progressive Lifecycle Activation]
       │ UNKNOWN -> DISCOVERED -> CONFIGURED -> AUTHENTICATED -> VERIFIED
       ▼
[5. Registry Updates]
       ├─ ProviderRegistry.update(provider, adapter)
       └─ CapabilityRegistry.update(capabilities)
       │
       ▼
[6. Cryptographic Evidence Anchoring] ──► EvidenceFabric (SHA-256 Merkle Chain)
       │
       ▼
[7. Semantic Memory Learning] ──► MemoryStore & SemanticIndex (Autonomous Experience)
```

---

## 4. Deterministic Discovery Replay

To guarantee that discovery decisions are deterministic, auditable, and immutable, the `DiscoveryReplayEngine` provides forensic evaluation:
- Re-evaluates candidate manifests against recorded verification states in strictly **READ-ONLY** mode.
- Does not mutate provider registries, does not trigger network probes, and does not alter lifecycle states.
- Returns a verdict of `IDENTICAL` when the candidate matches historical verification criteria, or `DIVERGENT` with explicit field-level diagnostic diffs.
