# Singularity Workbench — Canonical Execution Identity Specification (Phase 10)

## 1. Abstract & Epistemic Role

The **Execution Identity** (`ExecutionIdentity`) provides the cryptographic lineage, causal ancestry, and forensic traceability for every operation performed within the Singularity Workbench.

Every interaction—from the initial human prompt down to an atomic native syscall or memory query—possesses an immutable identity record that binds the intent, context digest, execution depth, parent execution ID, and trace ID into a single auditable graph.

---

## 2. Canonical Identity Zod Schema

Location: `src/runtime/identity/identitySchema.ts`

```typescript
export const ExecutionIdentitySchema = z.object({
  /** Globally unique trace identifier across the entire request graph */
  traceId: z.string().uuid(),
  
  /** Human or autonomous intent identifier */
  intentId: z.string().min(1),
  
  /** Cryptographic reference to the assembled cognitive context digest */
  contextId: z.string().uuid(),
  
  /** Globally unique identifier for this specific execution unit */
  executionId: z.string().uuid(),
  
  /** Parent execution ID (undefined for root executions) */
  parentExecutionId: z.string().uuid().optional(),
  
  /** Root execution ID that originated the request graph */
  rootExecutionId: z.string().uuid(),
  
  /** Target capability ID */
  capabilityId: z.string().regex(/^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$/),
  
  /** Target provider ID (bound during resolution) */
  providerId: z.string().optional(),
  
  /** Target adapter ID */
  adapterId: z.string().optional(),
  
  /** Session ID (for federated/scoped providers) */
  sessionId: z.string().optional(),
  
  /** Recursion and execution graph depth (0-indexed) */
  depth: z.number().int().min(0).max(10),
  
  /** Causation ID linking to the trigger event */
  causationId: z.string().min(1),
  
  /** Timestamp of identity inception */
  timestamp: z.string().datetime(),
  
  /** Immutable audit and classification tags */
  tags: z.array(z.string()).default([])
});
```

---

## 3. Derivation Invariants & Lineage Rules

### Invariant 1: Root Inception
When a request originates at the boundary:
- $traceId \gets \text{UUIDv4}()$
- $contextId \gets \text{UUIDv4}()$
- $executionId \gets \text{UUIDv4}()$
- $rootExecutionId \gets executionId$
- $parentExecutionId \gets \text{undefined}$
- $depth \gets 0$

### Invariant 2: Child Lineage Derivation
When an execution triggers a nested capability:
- $traceId_{\text{child}} \equiv traceId_{\text{parent}}$
- $rootExecutionId_{\text{child}} \equiv rootExecutionId_{\text{parent}}$
- $parentExecutionId_{\text{child}} \equiv executionId_{\text{parent}}$
- $depth_{\text{child}} = depth_{\text{parent}} + 1$
- $tags_{\text{child}} = \text{UniqueMerge}(tags_{\text{parent}}, tags_{\text{new}})$

### Invariant 3: Depth Overflow Hard Barrier
To strictly prevent execution divergence, stack overflow, and runaway autonomous recursive loops:
$$\text{depth} \le 10$$
If an identity derivation requests $\text{depth} > 10$, `ExecutionIdentityFactory` throws `RuntimeError.validation("[DEPTH_OVERFLOW] Execution depth exceeded maximum boundary of 10.")` fail-closed.

---

## 4. Lineage Graph Reconstruction

Because every evidence event captures `executionId`, `parentExecutionId`, and `depth`, any complete sub-graph can be reconstructed deterministically:

```
[Root Execution] (depth: 0, executionId: E0, parent: null)
       |
       +---> [Child Hop 1] (depth: 1, executionId: E1, parent: E0)
       |            |
       |            +---> [Child Hop 2] (depth: 2, executionId: E2, parent: E1)
       |
       +---> [Child Hop 1b] (depth: 1, executionId: E3, parent: E0)
```

Forensic verifiers enforce:
1. Every child’s `parentExecutionId` MUST exist in the evidence log.
2. The child’s depth MUST equal `parent.depth + 1`.
3. The child’s timestamp MUST NOT precede the parent’s timestamp.

---

## 5. Secret Redaction in Identity Metadata

Any tag, intent name, or metadata payload passed into the `ExecutionIdentityFactory` is scrubbed through `sanitizeSecrets()`:
- `sk-live-...` $\to$ `[REDACTED_SECRET]`
- `Bearer ...` $\to$ `[REDACTED_SECRET]`
- `-----BEGIN RSA PRIVATE KEY-----` $\to$ `[REDACTED_SECRET]`
