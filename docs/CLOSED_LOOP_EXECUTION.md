# Singularity Closed-Loop Execution & Memory Feedback (Singularity v2.0)

## 1. Closed-Loop Execution Lifecycle
The execution outcome is converted into structured learning to update future context:

1. **Outcome Interception:** Physical adapter execution result (`ExecutionResult`) or failure diagnostic is captured.
2. **Poisoning Defense & Sanitization:** Output payload is inspected for prompt injection attempts (`ignore previous instructions`, `bypass rules`) and secret patterns.
3. **Structured Memory Generation:**
   - On Success: Creates `MemoryClass.EPISODIC`, `MemoryCategory.OBSERVATION` with `contentType: "EVIDENCE"`, `source: MemorySource.EXECUTION`, and `confidence: 0.95` (corroborated by `evidenceRefs`).
   - On Failure: Creates `MemoryCategory.OBSERVATION` with error diagnostic and `confidence: 0.80`.
4. **No Permanent Ban on Failure:** Provider failures trigger structured fallback memories without permanently blacklisting providers non-deterministically.
5. **Physical Persistence:** Memory is saved to `MemoryStore` (SQLite WAL) and indexed into `SemanticMemoryIndex` (local 384-dim embeddings).
6. **Next Cycle Retrieval:** Future related intents retrieve this observation, informing subsequent routing and context assembly.

## 2. Provenance & Evidence Linkage
Every feedback memory strictly links to its underlying cryptographic audit trail:
- `evidenceRefs: [evidenceEventId]`
- `executionRefs: [executionId]`
- `tags: ["execution_feedback", capabilityId, providerId, "success" | "failure"]`
