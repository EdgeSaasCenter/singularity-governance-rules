# Singularity Workbench — Security Boundaries & Trust Architecture (Phase 10)

## 1. Threat Model & Architectural Axioms

The Singularity Workbench is designed under the assumption of an **adversarial computing environment**:
- External inputs may contain jailbreaks, prompt injections, and malformed structures.
- Candidate capability manifests may attempt to claim unauthorized scopes or execute malicious binaries.
- Federated providers may be compromised, slow, or malicious.
- Internal memory stores may be subjected to poisoning attacks.

### Fundamental Security Axioms:
1. `SECURITY > CORRECTNESS > DETERMINISM > AUDITABILITY > PERFORMANCE > CONVENIENCE`
2. `MEMORY ≠ AUTHORITY`, `MEMORY ≠ AUTHORIZATION`, `MEMORY ≠ VERIFICATION`, `MEMORY ≠ TRUST`
3. `FAIL-CLOSED BY DEFAULT`

---

## 2. The 7 Orthogonal Security Boundaries

```
[EXTERNAL WORLD / LLM / HUMAN]
       |
  (BOUNDARY 1: INGRESS & SCHEMA GATE)
       v
[EXECUTION IDENTITY FACTORY]
       |
  (BOUNDARY 2: MEMORY TRUST BOUNDARY & POISONING DEFENSE)
       v
[COGNITIVE CONTEXT & POLICY ENGINE]
       |
  (BOUNDARY 3: GOVERNANCE & APPROVAL GATES)
       v
[WEAVER ROUTER & PROVIDER REGISTRY]
       |
  (BOUNDARY 4: SCOPED PROVIDER GATEWAY & SESSIONS)
       v
[PHYSICAL ADAPTERS & NATIVE SYSCALLS]
       |
  (BOUNDARY 5: SANDBOX, TIME BOUNDING & REVOCATION)
       v
[EVIDENCE FABRIC]
       |
  (BOUNDARY 6: CRYPTOGRAPHIC INTEGRITY & APPEND-ONLY PERSISTENCE)
       v
[DETERMINISTIC REPLAY ENGINE]
       |
  (BOUNDARY 7: READ-ONLY SIMULATION ISOLATION)
```

---

### Boundary 1: Ingress Validation & Identity Inception
- Strict Zod validation on every incoming request schema.
- Instant minting of immutable `ExecutionIdentity` binding `traceId`, `contextId`, and `depth`.
- Hard recursion depth limit ($d \le 10$) preventing unbounded autonomous loops.

### Boundary 2: Semantic Memory Trust Boundary
- **Axiom:** Stored memories can NEVER grant authorization, bypass policy, or alter verification status.
- **Poisoning Defense:** Regex heuristics (`INJECTION_PATTERNS`) scan all memory content prior to persistence.
- **Evidence Cross-Checking:** Cited `evidenceRefs` must physically exist in `EvidenceStore`.

### Boundary 3: Governance Policy Engine & Approval Gates
- Risk-based execution gating:
  - `ZERO` / `LOW` Read operations: execute autonomously.
  - `MEDIUM` Write operations in Production: require human confirmation.
  - `HIGH` / `CRITICAL` / `DESTRUCTIVE` operations: strictly require explicit approval. Missing approval triggers `RuntimeError.policy()`.

### Boundary 4: Scoped Provider Gateway & Session Constraints
- Default-deny capability exposure. A provider with 100+ native tools exposes ONLY capabilities explicitly granted in its `ProviderScope`.
- Maximum risk level ceilings ($Risk(\text{plan}) \le MaxRisk(\text{scope})$).
- Session expiration enforcement ($TTL < \text{Now}() \implies \text{REJECT}$).
- Independent rate limiting and circuit breaking per provider.

### Boundary 5: Physical Execution & Revocation Race Protection
- In-flight provider status check immediately before adapter execution.
- If a provider is revoked while a request is in-flight, Weaver intercepts the invocation, prevents the physical call, and diverts to the secondary fallback candidate.
- Monotonic deadline budget strictly bounding physical execution time.

### Boundary 6: Evidence Fabric & Audit Chain
- Cryptographic SHA-256 event chaining ($H_n = \text{SHA256}(H_{n-1} + \text{Canonical}(E_n))$).
- Secrets redacted prior to hashing; raw keys are never stored.
- Forensic verification detects payload tampering, omitted events, and modified links.

### Boundary 7: Read-Only Replay Isolation
- Replay engine runs in pure mathematical evaluation mode.
- 0 network requests, 0 database writes, 0 registry mutations.
