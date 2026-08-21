# Singularity Semantic Memory Architecture & Vector Indexing (Singularity v2.0)

## 1. Local Semantic Indexing Model
The **Semantic Memory Index** operates locally with zero cloud dependencies using local embeddings and cosine similarity.

```
                    ┌────────────────────────────────────────────────────────┐
                    │                      MemoryRecord                      │
                    │               (content, category, scope)               │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                SHA-256 Content Digest                  │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │               384-Dim Vector Generator                 │
                    │              (all-MiniLM-L6-v2 compatible)             │
                    └───────────────────────────┬────────────────────────────┘
                                                │
                                                ▼
                    ┌────────────────────────────────────────────────────────┐
                    │                Embedding Provenance Ref                │
                    │    (model, version, contentDigest, createdAt)          │
                    └────────────────────────────────────────────────────────┘
```

## 2. Embedding Provenance & Invalidation Contract
Every indexed vector record attaches an immutable `EmbeddingRef`:
```typescript
interface EmbeddingRef {
  model: string;          // "all-MiniLM-L6-v2"
  version: string;        // "1.0.0"
  contentDigest: string;  // 64-char SHA-256 hex string of record.content
  createdAt: string;      // ISO datetime
}
```

- **Content Digest Invalidation:** If a memory's content is modified (`version` incremented), `contentDigest` changes. Any query comparing old `EmbeddingRef` flags the embedding as `isStale` and triggers automatic re-indexing.
- **No Vector Re-use:** Vectors generated for content $C_1$ cannot be reused for $C_2$.

## 3. Deterministic 8-Stage Retrieval & Ranking Engine

1. **Candidate Retrieval:** Queries physical SQLite `memory_records` by scope and category.
2. **Semantic Similarity Scoring:** Calculates cosine similarity against query vectors.
3. **Scope & Status Filtering:** Rejects memories from other tenants; filters out `SUPERSEDED`, `INVALIDATED`, `REVOKED`, and `ARCHIVED` records.
4. **Poisoning Defense:** Intercepts prompt injections, secret tokens, and fake `evidenceRefs`.
5. **Deduplication:** Normalizes text representations and merges duplicate facts, preserving the higher-confidence instance.
6. **Freshness Evaluation:** Applies decay penalty ($0.25$) to temporal categories (`TASK_STATE`, `OBSERVATION`) older than 24 hours. Permanent facts and procedural rules never decay.
7. **Deterministic Scoring Formula:**
   $$\text{Score} = (w_{\text{sim}} \cdot \text{sim}) + (w_{\text{conf}} \cdot \text{conf}) + w_{\text{ev}} + w_{\text{rec}} + w_{\text{rule}} - w_{\text{stale}}$$
8. **Context Budget Enforcement:** Packs highest-ranking memories strictly within `maxItems`, `maxCharacters`, and `maxTokens`.
