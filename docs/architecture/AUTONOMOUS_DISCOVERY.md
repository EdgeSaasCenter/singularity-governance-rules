# Singularity Architecture — Autonomous Capability Discovery Layer

## 1. Executive Summary & Epistemic Foundational Axioms

The Autonomous Capability Discovery Layer provides a formal, non-destructive observation and intake mechanism for external capability sources, local system descriptors, REST/OpenAPI contracts, and Model Context Protocol (MCP) endpoints into the Singularity Workbench runtime.

### Constitutional Invariants
- **Discovery $\neq$ Trust:** The mere syntactic parsing of a capability manifest or descriptor grants zero trust, authorization, or execution privilege.
- **Observation $\neq$ Authority:** Observational introspection of an external node cannot modify policy boundaries or elevate capability scopes.
- **Zero Arbitrary Execution:** Introspection and validation mechanisms are strictly non-destructive and sandboxed. Discovery mechanisms are forbidden from using `eval`, `new Function`, subshell execution, or executing arbitrary scripts supplied in metadata descriptors.
- **Fail-Closed Secret Sanitization:** Metadata descriptors containing credentials (API keys, Bearer tokens, private keys, JWTs) are canonically redacted prior to hashing, serialization, or recording into the Cryptographic Evidence Fabric.

---

## 2. Discovery Intake Sources & Trust Levels

```
                     ┌──────────────────────────────────────────────┐
                     │          Autonomous Discovery Engine         │
                     └──────────────────────┬───────────────────────┘
                                            │
         ┌──────────────────┬───────────────┴───────────────┬──────────────────┐
         │                  │                               │                  │
┌────────┴─────────┐ ┌──────┴──────────┐           ┌────────┴─────────┐ ┌──────┴──────────┐
│  LOCAL_MANIFEST  │ │   MCP_SERVER    │           │ REST_DESCRIPTOR  │ │  CONFIGURATION   │
│  (Internal Trust)│ │ (Untrusted/Ext) │           │ (Untrusted/Ext)  │ │ (Configured/Sys) │
└──────────────────┘ └─────────────────┘           └──────────────────┘ └──────────────────┘
```

### Discovery Source Taxonomy (`DiscoverySourceType`)
| Source Type | Default Trust Level | Verification Requirement | Isolation Constraint |
|---|---|---|---|
| `LOCAL_MANIFEST` | `INTERNAL` | 8-Axis Verification Engine | Process isolation, local sandbox |
| `MCP_SERVER` | `UNTRUSTED` | 8-Axis Verification Engine + Scoped Gateway | Strict Schema, Timeout, Rate Limiting |
| `REST_DESCRIPTOR` | `UNTRUSTED` | 8-Axis Verification Engine + OpenApi Parser | Strict Domain & Risk Gating |
| `GRAPHQL_SCHEMA` | `UNTRUSTED` | 8-Axis Verification Engine + AST Validation | AST Depth & Complexity Bounds |
| `CONFIGURATION` | `CONFIGURED` | 8-Axis Verification Engine | Administrative Signature |
| `REGISTERED_PROVIDER` | `INTERNAL` | In-Flight Health Re-verification | Runtime Health Telemetry |
| `MANUAL_DECLARATION` | `INTERNAL` | Identity & Scope Cross-Check | Static Signature Check |

---

## 3. Candidate Manifest Validation Pipeline

1. **Zod Strict Schema Validation (`DiscoveryCandidateSchema`):**
   - Validates semver format on provider and capability versions (`^\d+\.\d+\.\d+$`).
   - Validates hierarchical capability identity syntax (`^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$`).
   - Validates domain, operation, risk level, transport, and availability constraints.
2. **Duplicate Declaration Check:**
   - Detects collisions within the candidate's capability list and rejects duplicate declarations.
3. **Transport Alignment Check:**
   - Asserts that capability execution transport matches provider transport.
4. **Topological Circular Dependency Detection:**
   - Traverses the capability dependency graph using depth-first search (DFS) with path tracking to detect cycles ($A \to B \to A$) and abort immediately.
5. **Secret Sanitization Boundary:**
   - Recursively scrubs metadata fields against key patterns (`api_key`, `token`, `secret`, `password`, `bearer`, `private_key`) and substring patterns (JWT, RSA keys, URIs with credentials) via `sanitizeForEvidence`.

---

## 4. Integration with Cryptographic Evidence Fabric & Semantic Memory

Every discovery attempt emits structured, immutable events into SQLite-backed `EvidenceStore`:
- `DISCOVERY_STARTED`: Logged with candidate metadata, origin, and source trust level.
- `DISCOVERY_COMPLETED`: Logged with SHA-256 content digest, verified capabilities list, and lifecycle status.
- `DISCOVERY_REJECTED`: Logged with diagnostic failure codes upon schema, cycle, or security violation.

Upon successful registration, `DiscoveryEngine` records a semantic memory entry (`category: OBSERVATION`, `confidence: 1.0`, `scope: "global"`) detailing the discovered capabilities, enabling context-aware retrieval for the Cognitive Orchestrator.
