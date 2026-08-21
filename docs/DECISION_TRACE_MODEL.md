# Singularity Decision Trace & Replay Model (Singularity v2.0)

## 1. Decision Trace Schema
Every execution conducted by `CognitiveOrchestrator` generates an immutable `DecisionTrace`:

```typescript
interface DecisionTrace {
  traceId: string;           // UUID
  requestId: string;         // UUID
  executionId: string;       // UUID
  parentExecutionId?: string;// UUID | undefined
  depth: number;             // 0..20
  intent: string;            // Sanitized user intent
  contextDigest: string;     // 64-char SHA-256 hex string of CognitiveContext
  capabilityId: string;      // "domain.action"
  providerId: string;        // Chosen provider
  adapterId: string;         // Chosen adapter
  policyDecision: {
    allowed: boolean;
    requiresHumanApproval: boolean;
    isDestructive: boolean;
    riskLevel: CapabilityRisk;
    reason: string;
    policyRule: string;
  };
  weaverDecision: {
    decisionId: string;
    totalScore: number;
    fallbackChainCount: number;
    explanation: string;
  };
  status: OrchestrationStatus;
  startedAt: string;
  completedAt: string;
  latencyMs: number;
  evidenceRefs: string[];    // Canonical sorted array of EvidenceEvent IDs
  memoryUpdates: string[];   // Canonical sorted array of created MemoryRecord IDs
  traceDigest: string;       // 64-char SHA-256 hex string of canonical preimage
}
```

## 2. Cryptographic Digest Formula

$$\text{traceDigest} = \text{SHA256}(\text{canonicalStringify}(\text{sanitizedPreimage}))$$

All secret patterns (`sk-live-...`, `Bearer ...`) are redacted prior to computing `traceDigest`.

## 3. Deterministic Replay Engine (Read-Only)
The `DeterministicReplayEngine` reconstructs historical decisions without side-effects:
- Evaluates the registered capability against current `CapabilityRegistry` and `ProviderRegistry`.
- Compares `capabilityId`, `providerId`, `adapterId`, and `policyDecision.allowed`.
- If identical $\to$ returns `verdict: "IDENTICAL"`.
- If modified $\to$ returns `verdict: "DIVERGENT"` with exact divergence list.
- **Safety Invariant:** Replay is strictly READ-ONLY and will never execute physical side-effects or modify disk state.
