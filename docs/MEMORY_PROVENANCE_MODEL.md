# Singularity Memory Provenance & Confidence Model (Singularity v2.0)

## 1. Memory Classes & Formal Provenance

| Memory Class | Primary Source | Durability | Update Policy |
|---|---|---|---|
| `WORKING` | `SYSTEM` / `EXECUTION` | Ephemeral | In-flight / Session lifecycle |
| `EPISODIC` | `EVIDENCE` / `EXECUTION` | Permanent / Append | Linked to Evidence Fabric events |
| `SEMANTIC` | `USER` / `IMPORT` / `INFERENCE` | Long-term | Versioned / Superseded |
| `PROCEDURAL` | `RULE` (`.agents/rules/`) | Constitutional | Immutable (Filesystem source of truth) |

## 2. Confidence Hierarchy

$$\text{RULE} = 1.0 \;\;>\;\; \text{EVIDENCE\_VERIFIED} \ge 0.95 \;\;>\;\; \text{DIRECT\_OBSERVATION} \ge 0.90 \;\;>\;\; \text{EXECUTION\_RESULT} \ge 0.85 \;\;>\;\; \text{USER\_ASSERTION} \ge 0.75 \;\;>\;\; \text{INFERENCE} \ge 0.50 \;\;>\;\; \text{SUMMARY} \ge 0.40$$

## 3. Evidence Linkage & Verification
Memories derived from system execution maintain references in `evidenceRefs: string[]`.
- When `MemoryRetriever` processes memories, each reference is physically verified against `EvidenceStore`.
- If valid, the memory receives an evidence boost in ranking.
- If invalid or forged, the `PoisoningDefense` flags the record as unsafe.

## 4. Poisoning Defense & Security Boundary
1. **Memory as DATA:** Content extracted from memories is treated strictly as passive data, never as executable agent instructions.
2. **Prompt Injection Filters:** Patterns like `ignore previous instructions` or `delete all database records` are intercepted at retrieval time.
3. **Secret Redaction:** Tokens, API keys (`sk-live-...`), JWTs, and URI credentials are automatically redacted before SQLite persistence.
4. **Authority Claim Protection:** Any memory asserting `contentType: "RULE"` from outside the `PROCEDURAL` class is rejected.
